Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D83FD4B96
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 03:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfJLA7W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 20:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfJLA7W (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 20:59:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836EA2064A;
        Sat, 12 Oct 2019 00:59:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iJ5ke-0004Cx-IR; Fri, 11 Oct 2019 20:59:20 -0400
Message-Id: <20191012005747.210722465@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 11 Oct 2019 20:57:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/7 v2] tracing: Fix tracefs lockdown and various clean ups
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It appears that using destroy_inode() to clean up the proxy_ops that was
used by the lockdown code to have all open calls to the tracefs directory
was totally broken. It caused the inodes to not be cleaned up as the
destroy_inode() method is expected to clean up the inode, and not just what
it allocated as extra.

Linus suggested to get rid of the proxy_ops in tracefs, and just put the
checks in the open functions themselves. This also gives us a bit more fine
grain control to what exactly can be accessed.

Currently, I left the event format files (as they may need to be used by
something other than tracing), and enabled_functions, which shows what
functions are currently being traced. Not sure it is wise to not display
that information.

They can always be locked down later if need be.

Steven Rostedt (VMware) (7):
      tracefs: Revert ccbd54ff54e8 ("tracefs: Restrict tracefs when the kernel is locked down")
      ftrace: Get a reference counter for the trace_array on filter files
      tracing: Get trace_array reference for available_tracers files
      tracing: Have trace events system open call tracing_open_generic_tr()
      tracing: Add tracing_check_open_get_tr()
      tracing: Add some more locked_down checks
      tracing: Do not create tracefs files if tracefs lockdown is in effect

----
 fs/tracefs/inode.c                  |  46 ++----------
 kernel/trace/ftrace.c               |  55 ++++++++++----
 kernel/trace/trace.c                | 138 ++++++++++++++++++++++--------------
 kernel/trace/trace.h                |   2 +
 kernel/trace/trace_dynevent.c       |   4 ++
 kernel/trace/trace_events.c         |  49 +++++--------
 kernel/trace/trace_events_hist.c    |  13 +++-
 kernel/trace/trace_events_trigger.c |   8 ++-
 kernel/trace/trace_kprobe.c         |  12 +++-
 kernel/trace/trace_printk.c         |   7 ++
 kernel/trace/trace_stack.c          |   8 +++
 kernel/trace/trace_stat.c           |   6 +-
 kernel/trace/trace_uprobe.c         |  11 +++
 13 files changed, 220 insertions(+), 139 deletions(-)
