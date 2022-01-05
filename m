Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD54C4850A6
	for <lists+linux-api@lfdr.de>; Wed,  5 Jan 2022 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiAEKFl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jan 2022 05:05:41 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44270
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239203AbiAEKFk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Jan 2022 05:05:40 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A984C4000A
        for <linux-api@vger.kernel.org>; Wed,  5 Jan 2022 10:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641377138;
        bh=5D1xjiOTZGR/NYZwV/HYXBeCQP6CLWn6afeigaR+RhI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=TJxQx2ETAiOQcRjlc8+ec0FiXmDl731D6uKvtuzHTVOXRIJSaAwhyrRCipwkviNPU
         uqLoyG/jVnLDz0qwDTON6Sy9NdCdF26d8l5rc/ThkK30JG4BLao7ZoKaE4u3QoHXea
         XDtddASyjVlVss4r6Kd63cTVAHcKY0vKu4Bd3H+VRrYO1kM0W08Zyhij4YboF51e5h
         wezn3HZL5+dyhY6y8Sk8w82RoaDvt6VjHTmi5YDpeKreke6Rnw9E2e1D71t9fF302X
         kUpduWp5nKA8jJQMq3le8iJqmuq2vUMXaPzV1gTiuK8vhSUWp9xToDoAH7CHe6aRE2
         6X+/wGssLxxgA==
Received: by mail-ot1-f69.google.com with SMTP id j18-20020a9d1912000000b0058eff2b095bso10167058ota.7
        for <linux-api@vger.kernel.org>; Wed, 05 Jan 2022 02:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5D1xjiOTZGR/NYZwV/HYXBeCQP6CLWn6afeigaR+RhI=;
        b=1RIyZOhDtxuCmJefXlW45jsn3F09Zxx3nJD4cWo0fIrBX453X8KvPG5wPRdvaOtbml
         cStke319bc1jDH50Og47Fllhm1x2PU0J5i04SUedjhKCRXe9pAhkKeue7B/mPLlLjSMJ
         /1XITq2VBT8XraMwYT1Z322TkHB6/WMx1YUzP8kkmUT9DEx/gGvooquwvDXGww5cUVjn
         GO6G200qZP6YaMai2G7DzPk/kXhuhQdlkUjo+E6VSfjedoOITGlRjEuR5H43XSzlkYfD
         qSeq3kWPadFzxkKsxCWg5moRohQaJsWILpoxf3F9Vqt5axsZ5X+bqKAP2jZD60eJ7w/K
         FH8g==
X-Gm-Message-State: AOAM533geitiaf0TKm7Y0ZNJ+ekXY0tZg4fG1jaK6CqSokkQvH4SWRyJ
        /b7fmfaY/lrXXkcfcgyaYIDvSONdfAHdN3FC3v+zOgNEr9VP5K9FPGL4PfKPwt2MgIAWFKrDCxf
        ulDTmr3sc4RMX8hnXSRhCvXbgyWvGYjnJCC/KtPLCLHVgoPwv+gUBQw==
X-Received: by 2002:a05:6808:1445:: with SMTP id x5mr2013417oiv.146.1641377137602;
        Wed, 05 Jan 2022 02:05:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSxetywTS05F3LrKs6cZGyzYOlhWLLIzBvlpKZkAi3sZzki1WinEFEvYmM/4hhYZX5mg8FCJv4tka7ZKCUbmU=
X-Received: by 2002:a05:6808:1445:: with SMTP id x5mr2013396oiv.146.1641377137288;
 Wed, 05 Jan 2022 02:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-13-matthewgarrett@google.com> <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
 <20220105064827.GA30988@srcf.ucam.org> <CAAd53p5A9ajyP=8edXW20MB1eLRAF3SsmXfdnkA2isBJD2Bd+w@mail.gmail.com>
 <20220105072010.GA31134@srcf.ucam.org>
In-Reply-To: <20220105072010.GA31134@srcf.ucam.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 5 Jan 2022 18:05:26 +0800
Message-ID: <CAAd53p6VcAo0MVMWerTag42cWFE2ifzdQ=AFmGd9a=2gFjgv5A@mail.gmail.com>
Subject: Re: [PATCH V40 12/29] x86: Lock down IO port access when the kernel
 is locked down
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jan 5, 2022 at 3:20 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Wed, Jan 05, 2022 at 02:57:57PM +0800, Kai-Heng Feng wrote:
>
> > The affected system from the customer has SecureBoot enabled (and
> > hence lockdown), and the kernel upgrade surprisingly broke ioperm()
> > usage.
>
> Which kernel was being used that was signed but didn't implement
> lockdown? That sounds, uh, bad.

It was upgraded from older distro release. Older kernels don't have lockdown.

>
> > The userspace program is proprietary so I can't share it here.
>
> Ok. Are you able to describe anything about what it does so we can
> figure out a better solution?
>
> > Basically this patch makes ioperm() a noop on SecureBoot enabled x86 systems.
> > If reverting is not an option, what else can we do to circumvent the regression?
>
> There's two main choices:
>
> 1) Disable secure boot on the system in question - if there's a need to
> run userland that can do arbitrary port IO then secure boot isn't
> providing any meaningful security benefit in any case.

How so?
Other security features are still incredible valuable, we don't want
to toss them out just because someone has to use ioperm().

>
> 2) Implement a kernel driver that abstracts the hardware access away
> from userland, and ensures that all the accesses are performed in a safe
> way.
>
> Doing port IO from userland is almost always a terrible idea - it
> usually involves indexed accesses (you write an address to one port and
> then write or read data from another), and if two processes are trying
> to do this simultaneously (either because SMP or because one process
> gets preempted after writing the address but before accessing the data
> register), and in that case you can end up with accesses to the wrong
> register as a result. You really want this sort of thing to be mediated
> by the kernel, both from a safety perspective and to ensure appropriate
> synchronisation.

Agree, let me start a discussion with them.

Kai-Heng
