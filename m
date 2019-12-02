Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5166810E407
	for <lists+linux-api@lfdr.de>; Mon,  2 Dec 2019 01:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfLBAKQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 1 Dec 2019 19:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfLBAKQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 1 Dec 2019 19:10:16 -0500
Subject: Re: [GIT PULL] y2038: syscall implementation cleanups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575245415;
        bh=iqq6lXJBg3gll30hOu8A7AbbrXvqRaMX0FdwYnExI4E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GucPhqCDjnhKjZxtLEBJJpMAIv4XkqH/zUBiXM2apvnPV57uNwTqs11tTUQwkdD8/
         ndLB4RwV+UpKbRPqyulG6MA5xJiEXlm/jEjqGiGeWPiD+uhPbcfyefxFGuvkeFtqet
         1/ZnWnbMZCgTY2MnwLrWm4aTWxSKiDKuP9/sSqcQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a38Q_yhiyODpFd6ZqLv=QyKRmCm8FOMuSr4RPvGtWNPYw@mail.gmail.com>
References: <CAK8P3a38Q_yhiyODpFd6ZqLv=QyKRmCm8FOMuSr4RPvGtWNPYw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a38Q_yhiyODpFd6ZqLv=QyKRmCm8FOMuSr4RPvGtWNPYw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
 tags/y2038-cleanups-5.5
X-PR-Tracked-Commit-Id: b111df8447acdeb4b9220f99d5d4b28f83eb56ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ceb307474506f888e8f16dab183405ff01dffa08
Message-Id: <157524541577.21884.12235201329343796550.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 00:10:15 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux API <linux-api@vger.kernel.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 14:36:16 +0100:

> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git tags/y2038-cleanups-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ceb307474506f888e8f16dab183405ff01dffa08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
