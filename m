Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA0ECB53
	for <lists+linux-api@lfdr.de>; Fri,  1 Nov 2019 23:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKAWZL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 1 Nov 2019 18:25:11 -0400
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:56612 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbfKAWZL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 1 Nov 2019 18:25:11 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 18:25:10 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 1E2EE8026C45;
        Fri,  1 Nov 2019 22:15:10 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4774E182CED34;
        Fri,  1 Nov 2019 22:15:08 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::::::::::::::,RULES_HIT:41:69:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:3874:5007:6261:7875:10004:10400:10848:10967:11026:11232:11658:11914:12043:12296:12297:12438:12555:12663:12740:12760:12895:13069:13095:13143:13184:13229:13230:13311:13357:13439:13972:14180:14181:14659:14721:21080:21094:21323:21433:21451:21627:21740:30045:30054:30056:30090:30091,0,RBL:94.155.134.143:@goodmis.org:.lbl8.mailshell.net-62.8.41.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: shade52_49a12faf12c2a
X-Filterd-Recvd-Size: 2421
Received: from grimm.local.home (unknown [94.155.134.143])
        (Authenticated sender: rostedt@goodmis.org)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 Nov 2019 22:15:05 +0000 (UTC)
Date:   Fri, 1 Nov 2019 18:15:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     dann frazier <dann.frazier@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: tracefs splats in lockdown=confidentiality mode
Message-ID: <20191101181501.4beff81b@grimm.local.home>
In-Reply-To: <20191101210803.GA9841@xps13.dannf>
References: <20191101210803.GA9841@xps13.dannf>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 1 Nov 2019 15:08:03 -0600
dann frazier <dann.frazier@canonical.com> wrote:

> hey,
>   fyi, I'm seeing a bunch of errors from tracefs when booting 5.4-rc5 in
> lockdown=confidentiality mode:
> 
> [    1.763630] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> [    1.772332] Could not create tracefs 'available_events' entry
> [    1.778633] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> [    1.787095] Could not create tracefs 'set_event' entry
> [    1.792412] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> (...)
> [    2.899481] Could not create tracefs 'set_graph_notrace' entry
> [    2.905671] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
> [    2.913934] ------------[ cut here ]------------
> [    2.918435] Could not register function stat for cpu 0
> [    2.923717] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:987 ftrace_init_tracefs_toplevel+0x168/0x1bc
> [    2.933939] Modules linked in:
> [    2.937290] CPU: 1 PID: 1 Comm: 

Looks to me that it's working as designed ;-)

I'm guessing we could quiet these warnings for boot up though. :-/

But there should be at least one message that states that the tracefs
files are not being created due to lockdown.

-- Steve
