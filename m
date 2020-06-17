Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA11FD710
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2020 23:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFQVWT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Jun 2020 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQVWS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Jun 2020 17:22:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87514C06174E
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 14:22:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so1880847pge.12
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=10p96XOHb93iqxdsMtM/iXJsZQXP+bBYNuuroRQsAf8=;
        b=MWN8cZ9R5il23Sphk7/cpwDrjsrTR/+kkUhvqrDrigcLgNYhYnRJGvBWABWzskO8YK
         +fVFuJalBPUahrMWh8uCBsyPDo8OkrkT409WrBkWm++NCgvhsa5DtrkOWHPCUY905Gwr
         shxLSwAth2+Jg/yZQd8sSxszCwbxMiolkIV4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10p96XOHb93iqxdsMtM/iXJsZQXP+bBYNuuroRQsAf8=;
        b=gyRZ9Gs8hspqhAdDb3xgaiMSfrdA56+z0M0ONzLMU8HRUG2ebEitHZ+7T0F9+jCzMN
         n98nr9+0L3s4YX12N5NhpMaWeHHoG0j0u/GG0QyX4RoN1kKOHAHBHh0GCOCFZ9ntyiqx
         MO+peawOS/dDgYNhakhmDHWFvm714Xe7ZoBuU7jsiMT50j+B9uEkV4quX03iymvN5p49
         jHfpW5ugYcOsUaf5Rgu6jZGJ1dmoMdNhAoaC9vx+t0vB9Mh5Q16dCOO/MoE338PbFfkl
         Hfz6hNfoyeCw4VP1kjOiP2WXtQlDseHLLDPhS5GkqyHmO0BuWOwxsWgd80Mqy/yAnRFN
         o69w==
X-Gm-Message-State: AOAM5306gE+PS8jPnw7lzdytFwKnsTCs8g/lXTAsoiwNXngvOLp3E14e
        /TSkORJMS104OguCS+taRPn3AA==
X-Google-Smtp-Source: ABdhPJwb0QaHkNQ9STjpEw8h7dMc5MOUm/3dIDlXV+GrpRIAApEV64zC+Lai+OzQFtbZUC4Z/eKcQg==
X-Received: by 2002:a63:1617:: with SMTP id w23mr685649pgl.248.1592428938121;
        Wed, 17 Jun 2020 14:22:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l134sm648777pga.50.2020.06.17.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:22:17 -0700 (PDT)
Date:   Wed, 17 Jun 2020 14:22:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, cyphar@cyphar.com, jannh@google.com,
        jeffv@google.com, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v3] seccomp: Add find_notification helper
Message-ID: <202006171420.C8007EDCD8@keescook>
References: <20200601112532.150158-1-sargun@sargun.me>
 <20200617200844.GA12976@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617200844.GA12976@Ryzen-9-3900X.localdomain>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 17, 2020 at 01:08:44PM -0700, Nathan Chancellor wrote:
> On Mon, Jun 01, 2020 at 04:25:32AM -0700, Sargun Dhillon wrote:
> > [...]
> >  static long seccomp_notify_recv(struct seccomp_filter *filter,
> >  				void __user *buf)
> >  {
> > -	struct seccomp_knotif *knotif = NULL, *cur;
> > +	struct seccomp_knotif *knotif, *cur;
> >  	struct seccomp_notif unotif;
> >  	ssize_t ret;
> >  
> 
> I don't know that this should have been removed, clang now warns:
> 
> kernel/seccomp.c:1063:2: warning: variable 'knotif' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
>         list_for_each_entry(cur, &filter->notif->notifications, list) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/list.h:602:7: note: expanded from macro 'list_for_each_entry'
>              &pos->member != (head);                                    \
>              ^~~~~~~~~~~~~~~~~~~~~~
> kernel/seccomp.c:1075:7: note: uninitialized use occurs here
>         if (!knotif) {
>              ^~~~~~
> kernel/seccomp.c:1063:2: note: remove the condition if it is always true
>         list_for_each_entry(cur, &filter->notif->notifications, list) {
>         ^
> include/linux/list.h:602:7: note: expanded from macro 'list_for_each_entry'
>              &pos->member != (head);                                    \
>              ^
> kernel/seccomp.c:1045:31: note: initialize the variable 'knotif' to silence this warning
>         struct seccomp_knotif *knotif, *cur;
>                                      ^
>                                       = NULL
> 1 warning generated.

Eek; yes, thank you! I've folded the fix into Sargun's patch.

-- 
Kees Cook
