Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A71D79A0
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgERNUk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 09:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgERNUk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 09:20:40 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4FDC05BD09
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 06:20:40 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id 18so831233iln.9
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fgpdOynF6cHr+f7BfLRTcoqsZLiHJjSZb3oyMsov/Ak=;
        b=JLuJ5EyJnmImXOc3M2tKKSPI6B+PcA3dWkQ4oWB1yJLUGsMbea2I99AQvsy6jxwBcQ
         qNVhv6uqiP7/IC/qmcMSzpxqKau1sUzKlPuU+R9xvDB32WwKbCBYIXx2Uui6PbMev5m+
         Qv9O7KKI4REUBmO8NdXYlPh3q0kt6I64aefaM6irfkREpk1yB85ScH3gsX/icETPRC9S
         8R27qEENMhVWyXW0HjAvVl2VcYhagtg31vqk1rp3KgZ86NCcF5PjCSwKYR8a1VnZM0ax
         hhjfEaxGek1yFrzCSuPtOnTSkK4AN0ImEr3mGaeQJ83SsDA88BOOID+LscKjXhkE5ksB
         Nd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fgpdOynF6cHr+f7BfLRTcoqsZLiHJjSZb3oyMsov/Ak=;
        b=HkAxfVt7a0LpL3X+IU+E9LyZf6HKYPZhPZ9XaL8fdwxiA14MdxaPsl3gkctBZxYHLz
         hkMa/D3s7pYX7PfNzgTEb/KwFVzI7axr7dhmdChqEf9qh3hHXDgTerjZ4MbrFPxKuVtO
         cJjWDXaTbNzDco/n0m6ZlGDFgjWt+ZXqFKnrIPrYu5ggy5ysdtEy2IsUm9EmB6HEhWX2
         gI6z69EfQqYgrBZPvJ4slw5sU0ZS5waMlL4otkPBfYuRbeaCgEnmbucqbdAAd+a6FV+G
         xfpC4N5qP/JAUGn94DJFSfpbwp/+rRfohsfMzs/4Zm9dkg547yg60b27dbysqXnlR7Og
         XTsg==
X-Gm-Message-State: AOAM530bRRs8pL1ficgBCiEIaIHM3Tm7/Nzr9lAtImZ6t+Ek0gGbcYjI
        PKV4U1FQT8gfwUxK30SVaYV30w==
X-Google-Smtp-Source: ABdhPJyWutT81wIg9rwCkewuHKPqF07LUmx39cfM8OceBawpWLgFLbl7IiIAzFVfr8YTYknhJn3+Jg==
X-Received: by 2002:a92:507:: with SMTP id q7mr15605515ile.150.1589808039529;
        Mon, 18 May 2020 06:20:39 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:6155:7c8c:3dc0:c56e])
        by smtp.gmail.com with ESMTPSA id y12sm2715736ilk.16.2020.05.18.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:20:38 -0700 (PDT)
Date:   Mon, 18 May 2020 07:20:38 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Aleksa Sarai <asarai@suse.de>, Kees Cook <keescook@chromium.org>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200518132038.GA2405879@cisco>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
 <20200517150215.GE1996744@cisco>
 <20200518125325.l2lpixp3ch7zuiwx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518125325.l2lpixp3ch7zuiwx@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 18, 2020 at 02:53:25PM +0200, Christian Brauner wrote:
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
> > 
> > ?
> 
> Oh yes of course, sorry that was my stupid typo. I meant:
> 
> struct seccomp_notif2 {
>     __u32 notif_size;
>     __u64 id;
>     __u32 pid;
>     __u32 flags;
>     struct seccomp_data *data;
>     __u32 data_size;
>     __u32 new_field;
> }
> 
> at which point things should just work imho.

Are you saying that data_size is an input? Because I don't think they
Just Work otherwise.

Tycho
