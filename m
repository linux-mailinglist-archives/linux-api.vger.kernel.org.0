Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED530311A4B
	for <lists+linux-api@lfdr.de>; Sat,  6 Feb 2021 04:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhBFDjG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Feb 2021 22:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231334AbhBFDg4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 5 Feb 2021 22:36:56 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9401564FF2;
        Fri,  5 Feb 2021 22:49:53 +0000 (UTC)
Date:   Fri, 5 Feb 2021 17:49:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <20210205174951.47053c28@gandalf.local.home>
In-Reply-To: <YB3Kf896Zt9O+/Yh@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
        <YB11jybvFCb95S9e@alley>
        <20210205124748.4af2d406@gandalf.local.home>
        <YB3Kf896Zt9O+/Yh@chrisdown.name>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 5 Feb 2021 22:45:19 +0000
Chris Down <chris@chrisdown.name> wrote:

> >I'm not against the idea. I don't think it belongs in /proc. Perhaps
> >debugfs is a better place to put it.  
> 
> Any location is fine with me, as long as it gets to userspace. How does 
> <debugfs>/printk/formats or <debugfs>/printk/formats/<module> sound to you?

I'm fine with it, if others are.

Something like this will probably need approval from others on the Cc list
here.

-- Steve
