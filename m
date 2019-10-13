Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F58D5396
	for <lists+linux-api@lfdr.de>; Sun, 13 Oct 2019 02:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfJMAj0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 20:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbfJMAjZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 12 Oct 2019 20:39:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40EF720679;
        Sun, 13 Oct 2019 00:39:24 +0000 (UTC)
Date:   Sat, 12 Oct 2019 20:39:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/7 v2] tracefs: Revert ccbd54ff54e8 ("tracefs: Restrict
 tracefs when the kernel is locked down")
Message-ID: <20191012203922.3f29b258@gandalf.local.home>
In-Reply-To: <20191012203502.065258d2@gandalf.local.home>
References: <20191012005747.210722465@goodmis.org>
        <20191012005920.630331484@goodmis.org>
        <CAHk-=whE7GjKz9LtEVNw=zEgWr65N1mU7t2rA4MLiia8Zit6DQ@mail.gmail.com>
        <20191012203502.065258d2@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, 12 Oct 2019 20:35:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 12 Oct 2019 15:56:15 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Fri, Oct 11, 2019 at 5:59 PM Steven Rostedt <rostedt@goodmis.org> wrote:  
> > >
> > >
> > > I bisected this down to the addition of the proxy_ops into tracefs for
> > > lockdown. It appears that the allocation of the proxy_ops and then freeing
> > > it in the destroy_inode callback, is causing havoc with the memory system.
> > > Reading the documentation about destroy_inode and talking with Linus about
> > > this, this is buggy and wrong.    
> > 
> > Can you still add the explanation about the inode memory leak to this message?
> > 
> > Right now it just says "it's buggy and wrong". True. But doesn't
> > explain _why_ it is buggy and wrong.
> >   
> 
> Sure. The patches just finished my testing (along with other fixes that
> I need to send you). I have to make a few other updates in the change
> log though, so I'll be rebasing them (but not touching the code), to
> clean up the change logs.
> 

I updated this change log to state:

"I bisected this down to the addition of the proxy_ops into tracefs for
lockdown. It appears that the allocation of the proxy_ops and then freeing
it in the destroy_inode callback, is causing havoc with the memory system.
Reading the documentation about destroy_inode and talking with Linus about
this, this is buggy and wrong. When defining the destroy_inode() method, it 
is expected that the destroy_inode() will also free the inode, and not just 
the extra allocations done in the creation of the inode. The faulty commit 
causes a memory leak of the inode data structure when they are deleted."

-- Steve
