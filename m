Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7DD417B15
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345209AbhIXSaK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 14:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344604AbhIXSaK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 14:30:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2298C061613
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 11:28:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t20so7533771pju.5
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rf/DQgWol+2Qie0FLxwIYbvWdB4cIMthZm0XYX74FbA=;
        b=Q5OxGHQnN0WJ53D+/Vug4mK0zCYikMbYR5c6DETs6XRyLR89IY9hAyU9C/8bsaUmUO
         SufGaEWG+dKh8E5VUehdI90UMK5F9DiGJkczDVyCj02E8akUKR7KtwCjvHAE7VXzJ1yK
         JUeNJv4G0uydoLVZsqO1qV9hqAeXUSmih3iTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rf/DQgWol+2Qie0FLxwIYbvWdB4cIMthZm0XYX74FbA=;
        b=iaMVZBKVxrwcDgJrjRml9Valy/D0qGOGgiPvKg3dSlQ8UPX7IpW2007d1dZ2ft1Sdr
         5knnYun3zGXrz39rQmminc1dj+Trlye6gwoTA7L9wLgOVbtHFHA02ICEpSikftYMImLp
         bvFvsur1hcd4oOjp25QSwnt41lC/dwLi3yh2EuW05zIokYwwo+V8ehrhGTEL2Rug3K8b
         mE/l01YT/LxfgauaXskxmljxLA6HKwTnoC/UPFeP7n/phuFgB0rxU9m4bxkoUuLqtV+G
         TA1zzcwtHrWrNyCzwwwAbDxTiH0WJ5Uqm3vintKL+vGhQq+lXugrvQieyOc4+9Ulw7lB
         FOSw==
X-Gm-Message-State: AOAM531OjK1CJ1uZpvjuKRSWRFhhGiuh0u7cIdE8xFMwzDSBku/VlXM8
        BPXH9oZEl/LRepHGh+33J8znUA==
X-Google-Smtp-Source: ABdhPJxTCHnGUVkViNa5KY33kmg5e4iRbJOF121ZYSZL9Supg5zTiqqhyYVktyqOlcYmBCQxVe4vAQ==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr3900885pjo.29.1632508116320;
        Fri, 24 Sep 2021 11:28:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x21sm9818136pfa.186.2021.09.24.11.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 11:28:35 -0700 (PDT)
Date:   Fri, 24 Sep 2021 11:28:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 4/6] exit: Factor coredump_exit_mm out of exit_mm
Message-ID: <202109241128.E0A915F@keescook>
References: <87v92qx2c6.fsf@disp2133>
 <87a6k2x277.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6k2x277.fsf@disp2133>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 23, 2021 at 07:11:08PM -0500, Eric W. Biederman wrote:
> 
> Separate the coredump logic from the ordinary exit_mm logic
> by moving the coredump logic out of exit_mm into it's own
> function coredump_exit_mm.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yup -- mechanical refactoring looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
