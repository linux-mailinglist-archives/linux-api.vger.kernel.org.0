Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1CC1EAC8B
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2020 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgFASiD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Jun 2020 14:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgFASho (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Jun 2020 14:37:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1748C008632
        for <linux-api@vger.kernel.org>; Mon,  1 Jun 2020 11:26:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f21so3867900pgg.12
        for <linux-api@vger.kernel.org>; Mon, 01 Jun 2020 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vQsHm/Fb+3S9GG4hi4C54VWzmvQfSDfHYATb203csRU=;
        b=Vs7Yv/hX/ULE3o4BYT8jfnU2UW8Uy0ez3j2yQ8d6Stdt/38QVd16hvblONaRxgdbUK
         HfbmgcTRdgDtj0uTkJE/cNinFuhzfppdk2J2grs4bm465GiL6n76ZgakZKzTV8r6dxUM
         X7r7To/s/otOe8sf2hzW/wE30chaO+juxjXCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vQsHm/Fb+3S9GG4hi4C54VWzmvQfSDfHYATb203csRU=;
        b=een1zFCaU86CCbjQ3eu860/yrw+30oKF+fR05ocWW9cnWTcy44P2gKGgn0UekOyruJ
         T2YVb9RN6ixhnyoWQdbPl/Nq4zumfppxIpQu/MMUyQk+Xh92DoAgqxb7Xj6G/Nr1Nob4
         mOD+vcmhPbqt8aLh2rRTwBMA3SoPZYmn2WzjEs8gA35znBEtHXBZBdrWqadhVor+sIC6
         /Lb79SwVdDTwc/rnPmpwJ7pQNb3FOM0dAkGNJQ/SiZEdtZ9nCFtrGNPaRRQwGTLhHXrj
         n7XGDSNHV/uDQ+bc8KCjLKX1IG3PCYaDrAvxX1lwqSM7/FqnlietYJfFOkah0pCYu99S
         tv3w==
X-Gm-Message-State: AOAM5309v2l74GxzNBM/x4Y6mnCewx+ssKgbJqj1uqavcQ33cOONSLhy
        mkvDyAbMsMG4eBzl12PCuijyUg==
X-Google-Smtp-Source: ABdhPJy0Bj3McrkKbyUtGly01m03y4YOkwiHA40WeFmBiKfrbJdT7bHmuLQ//OCOxyp80PPGIZRcrw==
X-Received: by 2002:a63:7052:: with SMTP id a18mr20225520pgn.39.1591035993241;
        Mon, 01 Jun 2020 11:26:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm151966pjs.17.2020.06.01.11.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:26:32 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:26:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, cyphar@cyphar.com, jannh@google.com,
        jeffv@google.com, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v3] seccomp: Add find_notification helper
Message-ID: <202006011126.3DB757FBF5@keescook>
References: <20200601112532.150158-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601112532.150158-1-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 01, 2020 at 04:25:32AM -0700, Sargun Dhillon wrote:
> This adds a helper which can iterate through a seccomp_filter to
> find a notification matching an ID. It removes several replicated
> chunks of code.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> Cc: Matt Denton <mpdenton@google.com>
> Cc: Kees Cook <keescook@google.com>,
> Cc: Jann Horn <jannh@google.com>,
> Cc: Robert Sesek <rsesek@google.com>,
> Cc: Chris Palmer <palmer@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Tycho Andersen <tycho@tycho.ws>

Thanks! Applied to for-next/seccomp.

-- 
Kees Cook
