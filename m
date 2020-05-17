Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08181D6873
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2020 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEQOfo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 May 2020 10:35:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59066 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgEQOfo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 May 2020 10:35:44 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jaKOE-0001QS-2z; Sun, 17 May 2020 14:35:42 +0000
Date:   Sun, 17 May 2020 16:35:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Aleksa Sarai <asarai@suse.de>, Kees Cook <keescook@chromium.org>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200517143541.lh2mzuvcg7anobpc@wittgenstein>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 17, 2020 at 04:33:11PM +0200, Christian Brauner wrote:
> On Sun, May 17, 2020 at 08:23:16AM -0600, Tycho Andersen wrote:
> > On Sun, May 17, 2020 at 09:21:56PM +1000, Aleksa Sarai wrote:
> > > On 2020-05-17, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > > > Or... And that's more invasive but ultimately cleaner we v2 the whole
> > > > thing so e.g. SECCOMP_IOCTL_NOTIF_RECV2, SECCOMP_IOCTL_NOTIF_SEND2, and
> > > > embedd the size argument in the structs. Userspace sets the size
> > > > argument, we use get_user() to get the size first and then
> > > > copy_struct_from_user() to handle it cleanly based on that. A similar
> > > > model as with sched (has other unrelated quirks because they messed up
> > > > something too):
> > > > 
> > > > static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *attr)
> > > > {
> > > > 	u32 size;
> > > > 	int ret;
> > > > 
> > > > 	/* Zero the full structure, so that a short copy will be nice: */
> > > > 	memset(attr, 0, sizeof(*attr));
> > > > 
> > > > 	ret = get_user(size, &uattr->size);
> > > > 	if (ret)
> > > > 		return ret;
> > > > 
> > > > 	/* ABI compatibility quirk: */
> > > > 	if (!size)
> > > > 		size = SCHED_ATTR_SIZE_VER0;
> > > > 	if (size < SCHED_ATTR_SIZE_VER0 || size > PAGE_SIZE)
> > > > 		goto err_size;
> > > > 
> > > > 	ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
> > > > 	if (ret) {
> > > > 		if (ret == -E2BIG)
> > > > 			goto err_size;
> > > > 		return ret;
> > > > 	}
> > > > 
> > > > We're probably the biggest user of this right now and I'd be ok with
> > > > that change. If it's a v2 than whatever. :)
> > > 
> > > I'm :+1: on a new version and switch to copy_struct_from_user(). I was a
> > > little surprised when I found out that user_notif doesn't do it this
> > > way a while ago (and although in theory it is userspace's fault, ideally
> > > we could have an API that doesn't have built-in footguns).
> > 
> > But I thought the whole point was that we couldn't do that, because
> > there's two things that can vary in length (struct seccomp_notif and
> > struct seccomp_data)?
> 
> I may have missed that discussion you linked.
> But why wouldn't:
> 
> struct seccomp_notif2 {
> 	__u32 notif_size;
> 	__u64 id;
> 	__u32 pid;
> 	__u32 flags;
> 	struct seccomp_data data;
> 	__u32 data_size;
> };
> 
> struct seccomp_notif_resp2 {
> 	__u32 notif_resp_size;
> 	__u64 id;
> 	__s64 val;
> 	__s32 error;
> 	__u32 flags;
> };

(Ignore the missing 32 bits here.)
