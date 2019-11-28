Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84910CBB6
	for <lists+linux-api@lfdr.de>; Thu, 28 Nov 2019 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfK1Pbj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Nov 2019 10:31:39 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:46324 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1Pbj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Nov 2019 10:31:39 -0500
Date:   Thu, 28 Nov 2019 15:31:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1574955096;
        bh=jrPTZgi0SU4x8PDrknsTeduahbLr99zyjShTd7swWm4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=DWR+RBx1r49fxhEEvwf506KeubbDh7cTV/Gh20Uuetz+r+wT8yoUCjTAxuTw44Wz1
         FlgwK6mIc0S99+e/1Uu67LxCQU3GTDA6YPZc5B9esHWhQAVq2Z8geR14gPDLVkV4ay
         hp9RBO0Y9dLoQedLXRNDT44BZzJi8aG1rNVE16u0=
To:     Steven Rostedt <rostedt@goodmis.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     dann frazier <dann.frazier@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: tracefs splats in lockdown=confidentiality mode
Message-ID: <2vtDIdkutRsBBbaiswjFZlGeQPSlDHF3et5ZxQ4YJ4zArOKo7-53A6d8SwpUtt7NCYdQEmmkeTADvrS7NCzw0Stw33n44vJC_qspqXgRPZQ=@protonmail.ch>
In-Reply-To: <20191101181501.4beff81b@grimm.local.home>
References: <20191101210803.GA9841@xps13.dannf>
 <20191101181501.4beff81b@grimm.local.home>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Friday, November 1, 2019 10:15 PM, Steven Rostedt <rostedt@goodmis.org> =
wrote:

> On Fri, 1 Nov 2019 15:08:03 -0600
> dann frazier dann.frazier@canonical.com wrote:
>
> > hey,
> > fyi, I'm seeing a bunch of errors from tracefs when booting 5.4-rc5 in
> > lockdown=3Dconfidentiality mode:
> > [ 1.763630] Lockdown: swapper/0: use of tracefs is restricted; see man =
kernel_lockdown.7
> > [ 1.772332] Could not create tracefs 'available_events' entry
> > [ 1.778633] Lockdown: swapper/0: use of tracefs is restricted; see man =
kernel_lockdown.7
> > [ 1.787095] Could not create tracefs 'set_event' entry
> > [ 1.792412] Lockdown: swapper/0: use of tracefs is restricted; see man =
kernel_lockdown.7
> > (...)
> > [ 2.899481] Could not create tracefs 'set_graph_notrace' entry
> > [ 2.905671] Lockdown: swapper/0: use of tracefs is restricted; see man =
kernel_lockdown.7
> > [ 2.913934] ------------[ cut here ]------------
> > [ 2.918435] Could not register function stat for cpu 0
> > [ 2.923717] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:987 ftrace_=
init_tracefs_toplevel+0x168/0x1bc
> > [ 2.933939] Modules linked in:
> > [ 2.937290] CPU: 1 PID: 1 Comm:
>
> Looks to me that it's working as designed ;-)
>
> I'm guessing we could quiet these warnings for boot up though. :-/
>
> But there should be at least one message that states that the tracefs
> files are not being created due to lockdown.
>
> -- Steve

Could you clarify what functionality is lost here and if it affects
system stability?

I agree that triggering WARNING on every boot with supported kernel
configuration isn't optimal experience for users.

Jordan
