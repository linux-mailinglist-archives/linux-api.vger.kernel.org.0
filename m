Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9136E066
	for <lists+linux-api@lfdr.de>; Wed, 28 Apr 2021 22:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbhD1Ujs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Apr 2021 16:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhD1Ujr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Apr 2021 16:39:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4A2C06138A
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:39:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id md17so6024262pjb.0
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zX+hK2XOLgRiQ/qjPvLplrcpep/+GXekqfv3v8DoP8Y=;
        b=eznfVr2r6hniEBhA8Ti+a0WaocGIo4MLATqiMl0YuCwQdn7/ROGHFaGBkasECeL9Az
         fEWErThEPHa5OsYKa0GcUhBcxmaoAxsyjf5VOYBedtZmCOodHSC1O25SKBhGKCK1bySC
         7bmHayjv7zY6FC8zKZhK3XrVTNddE6Mi9fQ5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zX+hK2XOLgRiQ/qjPvLplrcpep/+GXekqfv3v8DoP8Y=;
        b=aBxmMFPUbAUe88VIYbkzK8us1kFvVAvFzc7PdhYRanVlPdqmQbrd65cT53IxsSoQIQ
         KDfScO8e8nzhKMmuPGv1tBboIvGRHVw5mezk/lhoYeAEwGvrSlROcMOcokQZwENFeubL
         +sto7NKiYlJfjjn3Zj7lKt6Uchc+y/MkHZr5Hx6fveg36W1wmgKKt5SOFQUbEWe+MNrD
         E2tZCdu3gKG1kH2120tGH/fBscI/uc5idBLcPMXVhsI25xKDYiQpQzmPbAHG4boK50ri
         IlSbC110rXcOYUhdYROfQlGUDsWRSK/rue7z5vQM9pOEGFQNhFDTuJsWdxOVAUlotkLt
         5EWg==
X-Gm-Message-State: AOAM5328+nlFaNnRIn3KhU+fa9S3n7+vH6qJnosBYclwqUISUQhPRDI0
        ykLEKh6lJ0qW7IC2wtGeRacm7w==
X-Google-Smtp-Source: ABdhPJxyZq7otCKoJchIV/jWvA6R5WarwWjbjwOrFjnZ0XQpOs4C90cIVIy2X5MXomN15cTXzU6s2w==
X-Received: by 2002:a17:90b:4017:: with SMTP id ie23mr5716039pjb.155.1619642340911;
        Wed, 28 Apr 2021 13:39:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k17sm320598pji.47.2021.04.28.13.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:39:00 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:38:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 6/9] x86/vdso: Insert endbr32/endbr64 to vDSO
Message-ID: <202104281338.223448FB@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-7-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:17PM -0700, Yu-cheng Yu wrote:
> From: "H.J. Lu" <hjl.tools@gmail.com>
> 
> When Indirect Branch Tracking (IBT) is enabled, vDSO functions may be
> called indirectly, and must have ENDBR32 or ENDBR64 as the first
> instruction.  The compiler must support -fcf-protection=branch so that it
> can be used to compile vDSO.
> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
