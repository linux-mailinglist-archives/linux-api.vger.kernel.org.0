Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E2410F3A0
	for <lists+linux-api@lfdr.de>; Tue,  3 Dec 2019 00:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfLBXy3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Dec 2019 18:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfLBXy3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 2 Dec 2019 18:54:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F2E2054F;
        Mon,  2 Dec 2019 23:54:27 +0000 (UTC)
Date:   Mon, 2 Dec 2019 18:54:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        James Morris <jmorris@namei.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: tracefs splats in lockdown=confidentiality mode
Message-ID: <20191202185426.432ca21b@gandalf.local.home>
In-Reply-To: <CACdnJuuXBQ__Sb8=V7CTZfXH=5LfbiU9SmUKapJov3Cd+aHQcw@mail.gmail.com>
References: <20191101210803.GA9841@xps13.dannf>
        <CACdnJuuXBQ__Sb8=V7CTZfXH=5LfbiU9SmUKapJov3Cd+aHQcw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 2 Dec 2019 15:31:52 -0800
Matthew Garrett <mjg59@google.com> wrote:

> On Fri, Nov 1, 2019 at 2:08 PM dann frazier <dann.frazier@canonical.com> wrote:
> 
> > [    1.763630] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7  
> 
> This is expected.
> 
> > [    2.913934] ------------[ cut here ]------------
> > [    2.918435] Could not register function stat for cpu 0
> > [    2.923717] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:987 ftrace_init_tracefs_toplevel+0x168/0x1bc  
> 
> This is not. I'll look into it.

I think it has to do with ftrace triggering WARN_ON() if it fails to
create files. We don't want this to happen if it fails because of
lockdown.

I'm already looking into it.

Thanks!

-- Steve
