Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4334A085
	for <lists+linux-api@lfdr.de>; Fri, 26 Mar 2021 05:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZEb0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Mar 2021 00:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhCZEa5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Mar 2021 00:30:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670CC0613E0
        for <linux-api@vger.kernel.org>; Thu, 25 Mar 2021 21:30:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l1so3777828pgb.5
        for <linux-api@vger.kernel.org>; Thu, 25 Mar 2021 21:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=35XopTC+7WOzIQnHzWXImRYQHw0CHWkdoXHcf/+9Onk=;
        b=FuXqSLOY5UJibY4x5cy44xNCqVYXhs/QB8SAK6Ph5plXJluUdlmzkl2vYUhpV/m3iz
         fBwsgAxyhUwk4l2OzfotcXS7ilTz5vz/4D0pRkceuJfu6MDHX6kEBtNhBX+0z1Q+x9Rq
         gJAq/6u1b6zvaFaFWLn9VBJN47ayz/H6CG+SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=35XopTC+7WOzIQnHzWXImRYQHw0CHWkdoXHcf/+9Onk=;
        b=WZ1IWIhlXu3uVYc5HLG2+Fev6xmOkivGCefCXvNVbFD7VeRS6JYUwpg6IBmMQotMXh
         bWkQ4NWvzQTVnuQ2zm2pAu5SOIJED1MaDg1KbojR7ew23EOloubLuBF/VKgHPeRBg1PS
         xZyCZoG/isCDs7iVGjjpa5Vivrd6aR7jVR9KxSD0P/wj3jq8uxRSPDRrY8ZDiRKPXksm
         oaWXRrEY3IqNhOdwC44jkOKhkCtUsf4Tn0M44ycyX+EvqjcQc89ZViuS/TKMNLtZcmD2
         jOPxBFxx3gA9//dG4KrLtyFGWTVnr1sruVDX7+8GeNSFGbu6J67RskbikeNMaGmNOzI+
         afRA==
X-Gm-Message-State: AOAM530snFPQwhl5yPnxtSfivmbk40O2fGwEIPLOu5gmYTenhN8T/81O
        lcsYzSvtKUBuCJ7SXS1OQ0a2PA==
X-Google-Smtp-Source: ABdhPJxJ4Uh8qq7VGivmsaxoe1yrWQkMSLzdjT7KyXHUDkthLjeUOIqUGrr9oa/zfMmenb3JnsesWA==
X-Received: by 2002:a62:7f86:0:b029:20a:a195:bb36 with SMTP id a128-20020a627f860000b029020aa195bb36mr11204021pfd.4.1616733055463;
        Thu, 25 Mar 2021 21:30:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm7098940pjc.24.2021.03.25.21.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 21:30:54 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:30:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v31 10/12] selftests/landlock: Add user space tests
Message-ID: <202103252130.54C78E4@keescook>
References: <20210324191520.125779-1-mic@digikod.net>
 <20210324191520.125779-11-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324191520.125779-11-mic@digikod.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 24, 2021 at 08:15:18PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Test all Landlock system calls, ptrace hooks semantic and filesystem
> access-control with multiple layouts.
> 
> Test coverage for security/landlock/ is 93.6% of lines.  The code not
> covered only deals with internal kernel errors (e.g. memory allocation)
> and race conditions.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
