Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3053C1B2A
	for <lists+linux-api@lfdr.de>; Thu,  8 Jul 2021 23:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhGHVq5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Jul 2021 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhGHVq5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Jul 2021 17:46:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0933C06175F
        for <linux-api@vger.kernel.org>; Thu,  8 Jul 2021 14:44:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a18so19021245lfs.10
        for <linux-api@vger.kernel.org>; Thu, 08 Jul 2021 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNUdXmAdyTLugzbXax99lK0jKXoIs2WTSE5WoZskvj0=;
        b=gbipal36mpQN7Afd0MiNy7ScPAzJbvar3bRjj/hZUcY5WhNk1EXDqng/H6wGZVJcW8
         yZ5nU1zw1U1j2XelewznZsv6R6ukoU2jfO4kRGVp2Dda3GDHEFTsbS7A7BAxIuJRTgTC
         k/bIveMZzbvdSdNgfrU8F4UlijzvkE1tTP+d63RGShTDmzDWhaj6vBrlxPyd84mR2AGw
         n2xWD8XfQ1QqRBb+/D1o27iXvJcObT5EKdHUJlBr38Nar30nX6s4hq/M+vgTFqhUcBCF
         pINtMibejBlp+pzAEh7V+hVPBl0mVAytJ4jPIAQvv6wQQl6XzSkK4ycJWwpPYNmgVKIt
         vDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNUdXmAdyTLugzbXax99lK0jKXoIs2WTSE5WoZskvj0=;
        b=LMzkCE0L0IcUtJldPQKTjjDBKK8QXsZHZikMzQ0ThzDNjvlYkS5PDhYQ912uqR1gk6
         pvyl/x/gFRLexCISKG2W1q8RJ6mmtm/XFEfSAprtA4XAYd/nXN9j6yr0Rbmy0pncddsU
         9PXR1wg1nS2ZdnIe2mHwCnq+uG0KeZ/eZPh++/KGxIRvAhPMmP1HjgYNmOCW6ATxtvhK
         SR2JeqR+Az+U/M/XyfkVUcWoQi+47uyH1kUfQC9LqObRQg0ZNQMAhkC3yW1oCWjtFuD3
         qB1QPPoXQt1mEkkyJceOvOFeO1JtJq1mWoBnUknWSLgFDAv6V5GjIco1Jj2fYV3ZU249
         nNLA==
X-Gm-Message-State: AOAM531Ajlwn76piCkJgc3TCTNawJjX5vGJdbry1qlmiZesSuCJS5xI1
        LDefNzUy/wV3s8zoHaQxLAZ3fBLBjXVh03RmW5Q+IA==
X-Google-Smtp-Source: ABdhPJz3WVDNPE2LfCzF+PEm4pDEl4OsjSePR4Mcd3LkAUO+MuEH/Fu5Nap7ddow2Wj2S3QASzxD/bK9rc1SmAPl6xQ=
X-Received: by 2002:ac2:4d4a:: with SMTP id 10mr15224978lfp.125.1625780651756;
 Thu, 08 Jul 2021 14:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <YMJTyVVdylyHtkeW@hirez.programming.kicks-ass.net> <96842d90-7d3b-efac-fe1f-6e90b6a83ee5@uwaterloo.ca>
In-Reply-To: <96842d90-7d3b-efac-fe1f-6e90b6a83ee5@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 8 Jul 2021 14:44:00 -0700
Message-ID: <CAPNVh5d12sEqwKj-=aXWOQjxBXLcmwgQ9KiRNSTtGhL9PVT9vw@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        pjt@google.com, posk@posk.io, Peter Buhr <pabuhr@uwaterloo.ca>,
        Martin Karsten <mkarsten@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 7, 2021 at 10:45 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
> Hi,
> I wanted to way-in on this. I am one of the main developer's on the Cforall
> programming language (https://cforall.uwaterloo.ca), which implements
> its own
> M:N user-threading runtime. I want to state that this RFC is an interesting
> feature, which we would be able to take advantage of immediately, assuming
> performance and flexibility closely match state-of-the-art implementations.

Hi Thierry,

Thank you for your message! I just posted a new version/approach:

https://lore.kernel.org/lkml/20210708194638.128950-1-posk@google.com/

Let's move the discussion to the new thread.

Thanks,
Peter

[...]
