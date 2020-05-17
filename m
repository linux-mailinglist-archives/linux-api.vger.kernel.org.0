Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464E1D6877
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2020 16:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEQOqG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 May 2020 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgEQOqG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 May 2020 10:46:06 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A162C05BD09
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 07:46:06 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id n11so7348444ilj.4
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d412oJBD3pfuimUjHxHhpHlclYrhvexlbGmnre+1iKE=;
        b=xQsNpCLdi+7JQUdxXLmPGZNTL2u7olPpjAOjD18z1UKs7h2oDZAlUGFKyTCLKAcyDx
         0ndIQWEKj7ubtO3vmD0cWwupW2ppRTzjdlPiVtgFLgXGkb4NfDzC3KdJAj1tbldMABcW
         9Lqsu8tj/h+g8k3/4v0t5h3iYv9GQw5I3YkeV0pY4xo7Jklki1MHeJVDSf+mwWboFoXH
         wV+VYPL8vCKFdZ4f36ng0Czk3Q1XX4muoBC/uZLSVnMWcLFEZ0uVHlMaO6S9H9jgiQjl
         8vfpkkoLEhw6tA1WpXCu79ba+VeAkjTdaboo+oZA3KRc8HxUPdPYGo6C4ogjocwF2b/z
         8bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d412oJBD3pfuimUjHxHhpHlclYrhvexlbGmnre+1iKE=;
        b=s4/vQTIaMoFEX995889LmpVmiAJs57H4+G77t7Qc/ShEiFFQvSGZrvVXLG20eaWf2A
         170KuBhD6DR/eWEpjnTqxGzr0rXS5+SO1UGut6akjG4xOyynle7s8oVm4MbP9Zz+ZZIY
         FI1JIFykKezYGLC24o50aVyczTcMR9eUR5gV5UG3072qOeFBqBr7eH/RKbESRFaaeHup
         WuMzIbFb6xXwJEGLqsQxHscJagtI93hKEGLXwEmXqOG5SxIYkPeJMvGR83belYtbGUVH
         k/Dzqf8o3ht/uvnw7RWDR06FQo2RUaBkWOwlBKQJBESXLp1bqoiHKYe3/T4AOgYgHoSL
         fdkg==
X-Gm-Message-State: AOAM532Az6curZ7PpZ9H2470sHxlfXKbJgjsGEasPDQjqOS8m411x0Wh
        3hrGtrk/JwxPB3UWW7m7fz2gYg==
X-Google-Smtp-Source: ABdhPJx2TWiaAEFi7wyQqmnYZyYqocgEQXyGU8bGs1hi3nLkFKSxeV2duahouTWonQ86Ez0Ok9+UWw==
X-Received: by 2002:a05:6e02:610:: with SMTP id t16mr1324017ils.187.1589726765311;
        Sun, 17 May 2020 07:46:05 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:6155:7c8c:3dc0:c56e])
        by smtp.gmail.com with ESMTPSA id a17sm1751768ilr.68.2020.05.17.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 07:46:04 -0700 (PDT)
Date:   Sun, 17 May 2020 08:46:03 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Aleksa Sarai <asarai@suse.de>, Kees Cook <keescook@chromium.org>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200517144603.GD1996744@cisco>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I guess you need to put data_size before data, otherwise old userspace
with a smaller struct seccomp_data will look in the wrong place.

But yes, that'll work if you put two sizes in, which is probably
reasonable since we're talking about two structs.

Tycho
