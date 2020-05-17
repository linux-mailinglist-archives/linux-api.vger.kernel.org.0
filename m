Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A11D6D78
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2020 23:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgEQVbB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 May 2020 17:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgEQVbB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 May 2020 17:31:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4FC061A0C
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 14:31:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b190so3966047pfg.6
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nl1jPUv4ba/yAtewxEYF9Vx5ehHzan7FcPOetz1sGxI=;
        b=clGboMqEVH0oyyAstusWn9pLsPGuJI2qTXOqf/fLKtmNWoo8PU8U4KP2i1KZsbuaVt
         ZVGmYLRPYusSG7WQp27LnGotSSiVFtdWBjg36zFTERbOW+EMPqf6y69jWaRLHHT/vias
         cVIIdpg0UDwKIC22zDZF7idLsYnz1Rns+G0xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nl1jPUv4ba/yAtewxEYF9Vx5ehHzan7FcPOetz1sGxI=;
        b=JwBol/K0o4iXbU0pp0ZNJjahtdr0wThH0eKSeXYn5wJbO4cKnFYHJUBnHTRcWPy1hs
         afgK6sHxDAUQH+W0AJUL+hIrVS9FBCVOgU/K5dBgXUtrGtQ8Iy0VrqE574XW2V0JJ7w4
         04VT7sj269v9lXYUafNabZObhAb+1Sw5/PKT8W18MHb4hP105yBPs14RegAymaIkTipG
         qVENgQxDy9whac0FToBXZAyUPtLKuqQ3WUbdGeM872poJFANYrbisCdKxclWixW5/QGa
         bbSZ/+Q0UOvEcr8Ele8yjuAjUhH7DANqNerh5jTIqEVfSKMjt5nVWmlhN1eiCtP2vcBW
         +Dcg==
X-Gm-Message-State: AOAM53243YJdfPWWgXCwVJ6r9w/QF83BNXGN6X5nww3dRPJTgA8EQIbf
        v0jXa4iG2n70ryNjeySBcf/Qcg==
X-Google-Smtp-Source: ABdhPJzCfFU0gNS2Aq6V0833NEvmUA1835E1WIVVA7nMgWzPKZOvAUqjmi04Tqob8alVDia22+egKA==
X-Received: by 2002:a62:6041:: with SMTP id u62mr7558083pfb.62.1589751060296;
        Sun, 17 May 2020 14:31:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b74sm6106085pga.31.2020.05.17.14.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:30:59 -0700 (PDT)
Date:   Sun, 17 May 2020 14:30:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <asarai@suse.de>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <202005171428.68F30AA0@keescook>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
 <20200517150215.GE1996744@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517150215.GE1996744@cisco>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 17, 2020 at 09:02:15AM -0600, Tycho Andersen wrote:
> On Sun, May 17, 2020 at 08:46:03AM -0600, Tycho Andersen wrote:
> > On Sun, May 17, 2020 at 04:33:11PM +0200, Christian Brauner wrote:
> > > struct seccomp_notif2 {
> > > 	__u32 notif_size;
> > > 	__u64 id;
> > > 	__u32 pid;
> > > 	__u32 flags;
> > > 	struct seccomp_data data;
> > > 	__u32 data_size;
> > > };
> > 
> > I guess you need to put data_size before data, otherwise old userspace
> > with a smaller struct seccomp_data will look in the wrong place.
> > 
> > But yes, that'll work if you put two sizes in, which is probably
> > reasonable since we're talking about two structs.
> 
> Well, no, it doesn't either. Suppose we add a new field first to
> struct seccomp_notif2:
> 
> struct seccomp_notif2 {
>     __u32 notif_size;
>     __u64 id;
>     __u32 pid;
>     __u32 flags;
>     struct seccomp_data data;
>     __u32 data_size;
>     __u32 new_field;
> };
> 
> And next we add a new field to struct secccomp_data. When a userspace
> compiled with just the new seccomp_notif2 field does:
> 
> seccomp_notif2.new_field = ...;
> 
> the compiler will put it in the wrong place for the kernel with the
> new seccomp_data field too.
> 
> Sort of feels like we should do:
> 
> struct seccomp_notif2 {
>     struct seccomp_notif *notif;
>     struct seccomp_data *data;
> };

I'm going read this thread more carefully tomorrow, but I just wanted to
mention that I'd *like* to extend seccomp_data for doing deep argument
inspection of the new syscalls. I think it's the least bad of many
designs, and I'll write that up in more detail. (I would *really* like
to avoid extending seccomp's BPF language, and instead allow probing
into the struct copied from userspace, etc.)

Anyway, it's very related to this, so, yeah, probably we need a v2 of the
notif API, but I'll try to get all the ideas here collected in one place.

-- 
Kees Cook
