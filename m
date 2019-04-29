Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024D2DA04
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 02:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfD2AHA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 28 Apr 2019 20:07:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44553 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfD2AG7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 28 Apr 2019 20:06:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so4420290pfm.11
        for <linux-api@vger.kernel.org>; Sun, 28 Apr 2019 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=n2mvnFGe7DhWnAVJ4HPTWEsItuKdoQBnBqAP6kIcYug=;
        b=Or6uEcGq20/dbV741dpgRcmnluoZolSsauu907Q2n5IqtHesTqLypagpN4KylfV4J4
         gV/Ri1WN8QiMSpSFwMNVrtg+g50Mh9dq9f59O5tPGvKm4CoKzYz808goOti/dswLGmR1
         AYMHlHdbG1/yE0hzyy72pnjLNc6uo7AC6CMfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n2mvnFGe7DhWnAVJ4HPTWEsItuKdoQBnBqAP6kIcYug=;
        b=QT5bxJ/g5YAKb5X9vLikCOtPrWgHoPjHu36jSn27/h/oeOaXDF0kyjQWRJJFzsRkpU
         rYYMUq2kcziVBsiTi85pXAU4tdCeK9LrRj4rvO4Aeq4CfwpVwdQ0UdOeQxwMqGpfmjri
         xKxG8YFuxeQT71Mtp15QZMez+XT375VxbABClwR/Sy4+CFxI3QvfS4yVeQzeL3rbEb4Q
         FnhQX0f4nigvsrPYoyaBbibsQcCjanBXXtyCSbbksPNfrqbdKrLA4AIOJZe85JNVxM9d
         XLl67hFEE85ma47r2KAtdCw3lqMQkRa3WeE4bOyanTx7QMk6iLkwa3pJ94Cyx2jNvUBN
         2dUQ==
X-Gm-Message-State: APjAAAU7OVyUaXN7GpP2Jnb7FzmWtUCypqNA5dmWQ6CuitVia9W94AZA
        Dy/IbpNEde/hXsjlkGoOauD5Zw==
X-Google-Smtp-Source: APXvYqwb6MwKjVD4beBIgVSrqvnOCys+S049kGs7qQXovjqAUY28iQ+jdtiBGffI7iAuh/EIjCR1vg==
X-Received: by 2002:a63:4714:: with SMTP id u20mr47465141pga.316.1556496419070;
        Sun, 28 Apr 2019 17:06:59 -0700 (PDT)
Received: from localhost (ppp121-45-207-92.bras1.cbr1.internode.on.net. [121.45.207.92])
        by smtp.gmail.com with ESMTPSA id w23sm44714029pgj.72.2019.04.28.17.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 17:06:57 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Matthew Garrett <mjg59@google.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr <cmr@informatik.wtf>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the running kernel image
In-Reply-To: <CACdnJus9AhAAYs-R94BH7HDuuQfXjgdhdqUR6Pvk9mxbuPx1=Q@mail.gmail.com>
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com> <059c523e-926c-24ee-0935-198031712145@au1.ibm.com> <CACdnJus9AhAAYs-R94BH7HDuuQfXjgdhdqUR6Pvk9mxbuPx1=Q@mail.gmail.com>
Date:   Mon, 29 Apr 2019 10:06:51 +1000
Message-ID: <87wojdy8ro.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Matthew Garrett <mjg59@google.com> writes:

> On Tue, Apr 16, 2019 at 1:40 AM Andrew Donnellan
> <andrew.donnellan@au1.ibm.com> wrote:
>> I'm thinking about whether we should lock down the powerpc xmon debug
>> monitor - intuitively, I think the answer is yes if for no other reason
>> than Least Astonishment, when lockdown is enabled you probably don't
>> expect xmon to keep letting you access kernel memory.
>
> The original patchset contained a sysrq hotkey to allow physically
> present users to disable lockdown, so I'm not super concerned about
> this case - I could definitely be convinced otherwise, though.

So currently (and I'm pretty new to this as I've only recently rejoined
IBM) we aren't considering access to the console to be sufficient to
assert physical presence on bare-metal server-class Power machines. The
short argument for this is that with IPMI and BMCs, a server's console
isn't what it used to be. Our console is also a bit different to x86:
we don't generally have bios configuration screens on the console.

In your example, a sysrq key would allow you to disable lockdown after
the system has booted. On Power though, we use Linux as a bootloader
(Petitboot: https://github.com/open-power/petitboot) so being able to
disable lockdown there allows an IPMI-connected user to prevent a signed
kernel being loaded in the first place. I don't know if this is
_actually_ worse, but it certainly feels worse.

There are of course some arguments against our approach. I'm aware of
some of them. I'm also very open to being told that not equating console
access with physical access is fundamentally silly or broken and that we
should rethink things.

Regards,
Daniel
