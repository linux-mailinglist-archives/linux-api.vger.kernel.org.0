Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC562CB093
	for <lists+linux-api@lfdr.de>; Tue,  1 Dec 2020 23:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgLAW6d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Dec 2020 17:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgLAW6d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Dec 2020 17:58:33 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622CFC0617A7
        for <linux-api@vger.kernel.org>; Tue,  1 Dec 2020 14:57:53 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id l23so2310458pjg.1
        for <linux-api@vger.kernel.org>; Tue, 01 Dec 2020 14:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gGPZVkS0BS7EX3qtKKqZonvL2UvrJlAXlI+Z6tp/Obo=;
        b=i4aAeWGyU4DZ/J5ItxCdN3Hm8dkZllgwH4DlRJXRMbXFzeuBNiEpFCMOPXl6SdjT4H
         Bjetwk4SLQ+rYxPSW+gIxGQhXo52pTGs4I/wxnZ0p0qLBphclbtyIjoflvlfWAokOLLS
         PxOQyYU4LV4J4TxIqejcXjKi6KQthpeWRqCHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gGPZVkS0BS7EX3qtKKqZonvL2UvrJlAXlI+Z6tp/Obo=;
        b=bTjfgEpY3G3RTx6TLo82HZ1HBiL9kRdS85Fc7mgRN8mg4sNfHJCTOmKXujNEfhyv6C
         pkX3wZEPbJnKbVL5O+T+4BZ2blOO8JRzdWzyEmSaIdJmm0vr/cUf/NTdWKjfimXqFJfP
         68DAYIH49FD7ZyXR+SXIT25QUec0JS7pSWPdSVWbd5c8tAP/DLMO0iARv44vdi+4l8+K
         QB0KfumQBQeckxzjgs5JJ/FhPm1/j1F9fYy0cbG5+yyrTUV/qst/HRlwdDuufm+WivM5
         M5wb8avxCkhn4oMeu7qmnTKP5t8pnRE7jCd0WnZeG0dDDLxYeIZsMKcoB0nqUBO4uq3i
         qJvg==
X-Gm-Message-State: AOAM533rny96aofW5degxS7B9CfUSViGbT6Z2Oezo5O5/zaKLa6xJTMY
        jfi/w5CTLAUhgxiurbwSs5V6Dw==
X-Google-Smtp-Source: ABdhPJxjQIgF4OUUx+XLdTNkmeUk+aNs7Cwk4t1xuqlQVJ6LLs4+Gvp7RAFlnO1u4uN26eoQL1tQIg==
X-Received: by 2002:a17:90a:e604:: with SMTP id j4mr5062597pjy.19.1606863472991;
        Tue, 01 Dec 2020 14:57:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm593202pgh.5.2020.12.01.14.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:57:52 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:57:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, gofmanp@gmail.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 4/7] entry: Support Syscall User Dispatch on common
 syscall entry
Message-ID: <202012011457.047EFC2@keescook>
References: <20201127193238.821364-1-krisman@collabora.com>
 <20201127193238.821364-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127193238.821364-5-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 27, 2020 at 02:32:35PM -0500, Gabriel Krisman Bertazi wrote:
> Syscall User Dispatch (SUD) must take precedence over seccomp and
> ptrace, since the use case is emulation (it can be invoked with a
> different ABI) such that seccomp filtering by syscall number doesn't
> make sense in the first place.  In addition, either the syscall is
> dispatched back to userspace, in which case there is no resource for to
> trace, or the syscall will be executed, and seccomp/ptrace will execute
> next.
> 
> Since SUD runs before tracepoints, it needs to be a SYSCALL_WORK_EXIT as
> well, just to prevent a trace exit event when dispatch was triggered.
> For that, the on_syscall_dispatch() examines context to skip the
> tracepoint, audit and other work.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Acked-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
