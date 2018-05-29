require "open-uri"
require "nokogiri"

module OddsChecker
  module CorrectScore
    class Crawler
      attr_reader :match

      def initialize(match:)
        @match = match
      end

      def url
        "#{match.url}correct-score/"
      end

      def bets
        @bets ||= html_scores.map do |html_score|
          Bet.new(
            match: match,
            score: score_for(html_score),
            probability: html_score.odds / odds_sum
          )
        end
      rescue => e
        puts "Crawling for: #{url} failed"
        raise(e)
      end

      def probability_sum
        bets.map(&:probability).inject(&:+)
      end

      private

      def score_for(html_score)
        goals_team_one, goals_team_two = team_goals(html_score)

        Score.new(
          team_one_goals: goals_team_one,
          team_two_goals: goals_team_two
        )
      end

      def team_goals(html_score)
        team = html_score.winner.gsub("-", " ").downcase

        if team == match.team_one.gsub("-", " ").downcase
          goals_team_one = html_score.winner_score
          goals_team_two = html_score.looser_score
        elsif team == match.team_two.gsub("-", " ").downcase
          goals_team_one = html_score.looser_score
          goals_team_two = html_score.winner_score
        elsif team == "draw"
          goals_team_one = goals_team_two = html_score.winner_score
        else
          fail "Team can not be associated! #{html_score.winner}"
        end

        [goals_team_one, goals_team_two]
      end

      def html_scores
        @html_scores ||= trs.map { |e| HtmlScore.new(e) }.select(&:valid?)
      end

      def score_rows
        trs
      end


      def odds_sum
        @odds_sum ||= html_scores.map(&:odds).inject(&:+)
      end

      def trs
        event_table.css("tbody > tr")
      end

      def event_table
        doc.css('table.eventTable').first
      end

      def doc
        Nokogiri::HTML(body)
      end

      def body
        URI.parse(url).read
      end
    end

    private

    class HtmlScore
      RESULT_REGEXP = /(?<winner>.+) (?<winner_score>\d+)-(?<looser_score>\d+)/

      def initialize(html)
        @html = html
      end

      def winner
        result_regexp_match['winner']
      end

      def winner_score
        Integer(result_regexp_match['winner_score'])
      end

      def looser_score
        Integer(result_regexp_match['looser_score'])
      end

      def valid?
        score_td.content != "Any Other Score"
      end

      def odds
        sum = all_odds.inject(&:+)
        average_all_odds = sum / all_odds.length

        1 / Float(average_all_odds)
      end

      private

      def result_regexp_match
        score_td.content.match(RESULT_REGEXP)
      end

      def score_td
        @html.css("td")[0]
      end

      def all_odds
        @all_odds ||= @html.css("td.bc")
          .map { |e| e.content }
          .select { |e| e != "" }
          .map { |e| eval("#{e}.to_f") + 1.0 } # FIXME: evil eval!
      end
    end
  end
end
