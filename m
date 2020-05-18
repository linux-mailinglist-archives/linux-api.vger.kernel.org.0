Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C513F1D7818
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgERMFt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 08:05:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58287 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgERMFt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 08:05:49 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jaeWg-0001cL-9J; Mon, 18 May 2020 12:05:46 +0000
Date:   Mon, 18 May 2020 14:05:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>, Aleksa Sarai <asarai@suse.de>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200518120545.w7fgyq56gwzzcdrf@wittgenstein>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
 <20200517150215.GE1996744@cisco>
 <202005171428.68F30AA0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005171428.68F30AA0@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 17, 2020 at 02:30:57PM -0700, Kees Cook wrote:
> On Sun, May 17, 2020 at 09:02:15AM -0600, Tycho Andersen wrote:
> > On Sun, May 17, 2020 at 08:46:03AM -0600, Tycho Andersen wrote:
> > > On Sun, May 17, 2020 at 04:33:11PM +0200, Christian Brauner wrote:
> > > > struct seccomp_notif2 {
> > > > 	__u32 notif_size;
> > > > 	__u64 id;
> > > > 	__u32 pid;
> > > > 	__u32 flags;
> > > > 	struct seccomp_data data;
> > > > 	__u32 data_size;
> > > > };
> > > 
> > > I guess you need to put data_size before data, otherwise old userspace
> > > with a smaller struct seccomp_data will look in the wrong place.
> > > 
> > > But yes, that'll work if you put two sizes in, which is probably
> > > reasonable since we're talking about two structs.
> > 
> > Well, no, it doesn't either. Suppose we add a new field first to
> > struct seccomp_notif2:
> > 
> > struct seccomp_notif2 {
> >     __u32 notif_size;
> >     __u64 id;
> >     __u32 pid;
> >     __u32 flags;
> >     struct seccomp_data data;
> >     __u32 data_size;
> >     __u32 new_field;
> > };
> > 
> > And next we add a new field to struct secccomp_data. When a userspace
> > compiled with just the new seccomp_notif2 field does:
> > 
> > seccomp_notif2.new_field = ...;
> > 
> > the compiler will put it in the wrong place for the kernel with the
> > new seccomp_data field too.
> > 
> > Sort of feels like we should do:
> > 
> > struct seccomp_notif2 {
> >     struct seccomp_notif *notif;
> >     struct seccomp_data *data;
> > };
> 
> I'm going read this thread more carefully tomorrow, but I just wanted to
> mention that I'd *like* to extend seccomp_data for doing deep argument
> inspection of the new syscalls. I think it's the least bad of many
> designs, and I'll write that up in more detail. (I would *really* like
> to avoid extending seccomp's BPF language, and instead allow probing
> into the struct copied from userspace, etc.)

It's great to hear that you're on this. I haven't had time to work on
this since our kernel summit session. :/
And so far, I really like what I hear. I had the same general thought
that not extending seccomp's bpf is what we want. And to stress this
again before the mails come flooding in: we really need this in seccomp
itself not in any current or future LSM. :)

> 
> Anyway, it's very related to this, so, yeah, probably we need a v2 of the
> notif API, but I'll try to get all the ideas here collected in one place.

Cool, I was kinda worried that people would think that's a crazy idea
but I really think we're better off with a redesign. And I think that's
totally ok and cleaner than hacking around it.

Christian
