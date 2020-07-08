Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50971219490
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 01:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGHXs0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jul 2020 19:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgGHXsZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Jul 2020 19:48:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F67C061A0B
        for <linux-api@vger.kernel.org>; Wed,  8 Jul 2020 16:48:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so42565plm.10
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2020 16:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KX2uewx3IUSFSrhS49nvHbreqfSp55lLuPQ39ByWwuc=;
        b=VSTVR4XDCZkzC8WSBJX/KM/kGq0iHH2AcaBaZDwX5J91prDWjxtRm3s3HYgPSgN/gH
         veaQZ9BPpfL/s4wD2q9BT8GIPNH9KkzzQ2iS0XPhAxWjlDKuLM7GqVWkH4fj6SxMa+gR
         +SwRkobGC4/zeqpOJAwzIZX+ALIgbBGzMliAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KX2uewx3IUSFSrhS49nvHbreqfSp55lLuPQ39ByWwuc=;
        b=ucAFTELb5GwgBcgWsT/FzYYkvTTxgT3/y/4Ar2VyIA4tIyJ4qJZ4OMBmtAh8LU/QSL
         oxG8B40e5TvksIo1IE0vkGHLSgzM6NknJx3Q+dsV+56rm6LcGi3mPn16zRXjhHJuYrsJ
         v5Sk5TKnc/ooeGkQRF77pKYc7QYsgzYNoZQWCotTIT2Itzhu8ndFi0llvexjMdAA0AKA
         TUIK/jWO+cPi8j6IJfUFA6BeSV0OLOZQLCmtGQdbrQ6kcHFASl0JfeyfcgMjzTCCGUxy
         S6FCBpXCkDYdea46hTGUv+6ENo3z7ZCmvqwPOI8A+yZRC3HRCwW6kmCv4oBmHJ7zIzit
         VwoA==
X-Gm-Message-State: AOAM530cjPUBKrihTqLOlahu0pDu0a9vuFk1ml0Iacou2mb3cL0j5pQZ
        ncwF2tFnMmkBWebGE6o/sEEjGg==
X-Google-Smtp-Source: ABdhPJyiszI8/x+0s4vNHYAvtZesBdjqbGz/Qvm/wRI0AQQLImcB72/hJw/YuEZdEteyZw91l1ugpw==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr53578773plz.9.1594252105178;
        Wed, 08 Jul 2020 16:48:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i125sm794790pgd.21.2020.07.08.16.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:48:24 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:48:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 3/7] fs: Add receive_fd() wrapper for __receive_fd()
Message-ID: <202007081646.59E1A664@keescook>
References: <20200706201720.3482959-1-keescook@chromium.org>
 <20200706201720.3482959-4-keescook@chromium.org>
 <20200707114923.6huxnb4e5vkl657a@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707114923.6huxnb4e5vkl657a@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 07, 2020 at 01:49:23PM +0200, Christian Brauner wrote:
> On Mon, Jul 06, 2020 at 01:17:16PM -0700, Kees Cook wrote:
> > For both pidfd and seccomp, the __user pointer is not used. Update
> > __receive_fd() to make writing to ufd optional via a NULL check. However,
> > for the receive_fd_user() wrapper, ufd is NULL checked so an -EFAULT
> > can be returned to avoid changing the SCM_RIGHTS interface behavior. Add
> > new wrapper receive_fd() for pidfd and seccomp that does not use the ufd
> > argument. For the new helper, the allocated fd needs to be returned on
> > success. Update the existing callers to handle it.
> > 
> > Reviewed-by: Sargun Dhillon <sargun@sargun.me>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Hm, I'm not sure why 2/7 and 3/7 aren't just one patch but ok. :)

I wanted to do a "clean" move from one source to another without any
behavioral changes first.

> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!

-- 
Kees Cook
