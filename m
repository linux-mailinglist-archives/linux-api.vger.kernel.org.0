Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8912D3FA
	for <lists+linux-api@lfdr.de>; Mon, 30 Dec 2019 20:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfL3Tde (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 14:33:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44136 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfL3Tde (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 14:33:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so44810937otj.11
        for <linux-api@vger.kernel.org>; Mon, 30 Dec 2019 11:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9mNn9nURZI+7bF8xI34SvARdK0zc98BlyBAff05Zwow=;
        b=YV085ZOOvhc6d7lXQ0SBArTWIZoH8sYIamOti1KC9sHJJJ+d/rvFCoE55WfIvMkNNP
         OSD298oJWMMz/40hbSmOxuUqPIVB+eBibxKww9917VHEsbn3sSamO4XvE6a6L7YyeuFt
         GSGpITqm8hPZVEOetsAKoF7x54l97GAa6AtLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9mNn9nURZI+7bF8xI34SvARdK0zc98BlyBAff05Zwow=;
        b=RLOKmV1KaBv5NKZzBIhNQeYKNfXziF2HDQlYEabWzTGqljjRQy1jHpey5C+q1ZDQmW
         QyW/xz1p0lmFtllIhCUONOFG/x47B1iF6GxQoQGCRYe1T7EQyt5t5H7Khl0uNmvamHEY
         xbyJnszOvcPzBrM/KIKJUpTUlSlxsqIEpdmtgkPzdsQcaaQ4U21J4wl23TZqDJCnfJ+s
         RaeA+Jh9AoFLts2bRPavLIyibCFCvS+8hicJVIDm4vJIuG2CpOqjiujFRT6e84Kgg8a8
         v6fTVGILY4SxgaZ87F4fVw0iTmyYAbxJLb/9sDpEnJf6B4oQdXkth0dRWfWTPw65Pcik
         vPOA==
X-Gm-Message-State: APjAAAXdTE3soSw9yaE91KyExoLrGhs1FYB/29Y721ECf/iP2Ln4i0X3
        NX9gJMAOstvT0cWJsQKerH4jKA==
X-Google-Smtp-Source: APXvYqyNoTK/EBegjIbIVpgtIGqEsgAPyx26q0BAOQObqFaX7RqA6Ux749p7HJwSPup6gF+Ww3bYog==
X-Received: by 2002:a05:6830:2099:: with SMTP id y25mr73259465otq.87.1577734413863;
        Mon, 30 Dec 2019 11:33:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12sm16083437oti.22.2019.12.30.11.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:33:33 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:33:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <201912301132.5C97DD231B@keescook>
References: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
 <20191228181825.GB6746@cisco>
 <CAMp4zn91GoB=1eTbc_ux4eNs2-QFm+JocodgFQYUiiXL7H4m9w@mail.gmail.com>
 <20191229001818.GC6746@cisco>
 <CAMp4zn9s1wJyb9xHj4xYL5HTtM=gA07ZfBGTSW5j4ayUzaoZNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn9s1wJyb9xHj4xYL5HTtM=gA07ZfBGTSW5j4ayUzaoZNQ@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Dec 30, 2019 at 11:14:44AM -0800, Sargun Dhillon wrote:
> On Sat, Dec 28, 2019 at 4:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Sat, Dec 28, 2019 at 07:10:29PM -0500, Sargun Dhillon wrote:
> > > On Sat, Dec 28, 2019 at 1:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > >
> > > >
> > > > I know it's unrelated, but it's probably worth sending a patch to fix
> > > > this to be sizes.seccomp_notif_resp instead of sizeof(*resp), since if
> > > > the kernel is older this will over-zero things. I can do that, or you
> > > > can add the patch to this series, just let me know which.
> > >
> > > I was thinking about this, and initially, I chose to make the smaller
> > > change. I think it might make more sense to combine the patch,
> > > given that the memset behaviour is "incorrect" if we do it based on
> > > sizeof(*req), or sizeof(*resp).
> > >
> > > I'll go ahead and respin this patch with the change to call memset
> > > based on sizes.
> >
> > I think it would be good to keep it as a separate patch, since it's an
> > unrelated bug fix. That way if we have to revert these because of some
> > breakage, we won't lose the fix.
> >
> > Cheers,
> >
> > Tycho
> 
> As I was doing this, I noticed that the self-tests all use hard-coded struct
> sizes. When I was playing with extending the API, all of a sudden all the
> self-tests started failing (until I recompiled them against newer headers).
> 
> Should we also change the self-tests to operate against the seccomp
> sizes API, or was it intentional for the self-tests hard-coded the struct
> definitions, and locked to the kernel version?

I intend the seccomp selftests to be kernel-version tied, but I'd like
them to fail as gracefully as possible on mismatched kernel versions...

-- 
Kees Cook
