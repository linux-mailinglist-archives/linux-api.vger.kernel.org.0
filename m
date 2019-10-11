Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1FD49B4
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 23:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfJKVL4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 17:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfJKVL4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 17:11:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E35B2190F;
        Fri, 11 Oct 2019 21:11:54 +0000 (UTC)
Date:   Fri, 11 Oct 2019 17:11:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for
 lockdown
Message-ID: <20191011171152.0e6f4615@gandalf.local.home>
In-Reply-To: <CAHk-=wiGtEDhwJab7+tQzmjDssynBruRvgj9NJY2bzNrVzw+0Q@mail.gmail.com>
References: <20191011135458.7399da44@gandalf.local.home>
        <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
        <20191011162518.2f8c99ca@gandalf.local.home>
        <20191011165455.32666d53@gandalf.local.home>
        <CAHk-=wiGtEDhwJab7+tQzmjDssynBruRvgj9NJY2bzNrVzw+0Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 11 Oct 2019 14:00:50 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Oct 11, 2019 at 1:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I guess I can keep it this way. Thoughts?  
> 
> That looks fine to me. I'm still not sure you actually need to do all
> this, but it doesn't look _wrong_.

Yep, I sent this before seeing your other email.

> 
> That said, I still do think that if things are locked down from the
> very get-go, tracefs_create_file() shouldn't even create the files.

Agreed. I forgot to add in my last email:

4) Add the lockdown check to create_file()

> 
> That's mostly an independent thing from the "what about if they exists
> and things got locked down afterwards", though.

Well, I'll be combining it with the tracing_disabled code, which was
there originally to prevent corrupted buffers from causing harm by
being read.

> 
> I do wonder about the whole "well, if you started tracing before
> locking things down, don't you want to see the end results"?
> 

I don't think it hurts to disable it. Although, I don't think reading
the trace event formats will be a issue. I'm not aware of any of them
from giving too much info to the system. And if you really do care
about that, do it at boot up, and with the create_file part, it wont
have any files to read.

-- Steve
