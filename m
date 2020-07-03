Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91797213AFE
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2020 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGCN3v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCN3v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 09:29:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE321C08C5C1
        for <linux-api@vger.kernel.org>; Fri,  3 Jul 2020 06:29:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so1250568lji.2
        for <linux-api@vger.kernel.org>; Fri, 03 Jul 2020 06:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6zEQxvzQothZO05B4Wll0a1I7lNr/ukJgbFHD247Sw=;
        b=Q+uRhAVOIHXP3l5DGk1/AYscHvETYA8Ymm5mRBlR/XZ2o2UW9mnCLU7VESU4lL2OEy
         eZ7C26WENmNIB+gotFApffDk/Lm7wJJqW5WXxjtTJj6ZiS4cgcRVF/lud+lYD1VwE1xf
         cpzjiyELopP+C254O+Z8QVDXT6TXntwWbSEvwdpuLJb4iJGFg0nif+DbsqwcsfIyngvR
         cwwjXDlL0psFU3T01tJoAkowFEsXFjdqFGfsuc6+LYN6r4gQLlzEBZ55aY5+vXoDAqAM
         Cowz37opXoR4SPkIBRF8f/Wk2fYINKRcK4N7PEfRIqRnbLoh53R1SadZbb95BsxIbR06
         8FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6zEQxvzQothZO05B4Wll0a1I7lNr/ukJgbFHD247Sw=;
        b=QhrzTALPhogAd0XMJBpyNnYfxldcu2AEragGORpvlBIlJaG0EjS01aAlL0VsBKHl3J
         z2m4NwbX1SvtVu61yul/jfwZAlvosXuovIOY+7WN+HAFQwoL2CTDUmcpG4ApFowE6Xy8
         OfyADYa3HrfoI/gnoiZLLcFNZ0M4MfadMwNkzFZ9MWG4u7YUxxVO+DgbPvgAnO0e5UD3
         1hGY4IfHSgqEKIjne7MrQyaQgA4ZI3LCUQdw7B+w66Z45/GnWqtTV8LctT9veKiFUupa
         c7JQktUmUugTkQm2Keg5bBDHhRFnZf7aIhdGjK3/ooVT3cj2LHkFK6m7aYYViEpfUPP+
         QSsA==
X-Gm-Message-State: AOAM5325ixZh/T6raRHFG09fPOSkld4w5zKjS5m1+YWVExiBHYEC9Fdi
        D1vRiCYOtLxDKhNmTB2JRmewbDXpBndtCb6OdLkzTQ==
X-Google-Smtp-Source: ABdhPJyEDqX5CTF1WB5GWdO0bVAwepG+Vq+Mz8st/b4+OZW1Wmil9vt0PgmzZxcYnwapEuHceWJOgE/vqRlZbxTSVp8=
X-Received: by 2002:a2e:9dcc:: with SMTP id x12mr3182797ljj.415.1593782989137;
 Fri, 03 Jul 2020 06:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com> <20200703113026.GT18446@dhcp22.suse.cz>
In-Reply-To: <20200703113026.GT18446@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 3 Jul 2020 15:29:22 +0200
Message-ID: <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 3, 2020 at 1:30 PM Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
> > This patch adds logic to the kernel power code to zero out contents of
> > all MADV_WIPEONSUSPEND VMAs present in the system during its transition
> > to any suspend state equal or greater/deeper than Suspend-to-memory,
> > known as S3.
>
> How does the application learn that its memory got wiped? S2disk is an
> async operation and it can happen at any time during the task execution.
> So how does the application work to prevent from corrupted state - e.g.
> when suspended between two memory loads?

You can do it seqlock-style, kind of - you reserve the first byte of
the page or so as a "is this page initialized" marker, and after every
read from the page, you do a compiler barrier and check whether that
byte has been cleared.
