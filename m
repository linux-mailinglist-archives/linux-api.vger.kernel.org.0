Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A110447C
	for <lists+linux-api@lfdr.de>; Wed, 20 Nov 2019 20:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfKTTqV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Nov 2019 14:46:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41363 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfKTTqT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Nov 2019 14:46:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id m4so458136ljj.8
        for <linux-api@vger.kernel.org>; Wed, 20 Nov 2019 11:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4GCAZq/uEGcflB5X2TUEKapPXWlMYkV/UtTnBsKpco=;
        b=RxrnU9Zdl4qfrpzjYpyaAwAzY3XG/Ry8sSMBDTALfDbrJKNq6lonVJs86WghdReGSb
         q45rbMINZQcSQBcg70Nq9j+IAHEwqOnSBqakByyWfvUAPcN9Z19YUXtPjvRykksd/JQX
         uKQsqv/rx+Vm2XY+DmpAjU7u8YtknBJEgq1hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4GCAZq/uEGcflB5X2TUEKapPXWlMYkV/UtTnBsKpco=;
        b=KZTOFDjXUYAML7BTqeFg1PKOvPBB/X3F8LDtKgAd6/A/P5vX4zaSNAXTY3qoa6yotM
         mGOGOmHh4rjFpcKJCogbOmeVBbKuHHrQ9a1Pq5e1CR3dVyL+pEjELwRMajAkhTZRmz2r
         uQcv+PKc720KjqZ7SOUzLoZEMEQDPcql/DM7X1LC2H+tRHefwy7sjQ6hQ8wzkiYj52Wg
         GSPyeivPXs1LLISWVaK3iKy5kfK18qkY38D6X4fEd01Z7809cDI22pobSaSSV3NNSRV/
         7Wo28mV6wNfL00AELEC/YcpVIqKB8a1u+Q4BxKXEBJaCZKfZefbeUio83AG60Lc5xe+S
         apVw==
X-Gm-Message-State: APjAAAWE3vvBAxJg2jldlX4mMm2Ml1WHo8T0oUmADTNc0+pPgbL+Mvju
        xLnpgbA1uUdG3/0hgVUYRBRFxoSdjE8=
X-Google-Smtp-Source: APXvYqwV9sVP0ExMEVdDj0aHPcA14r09OtFS/VzQDzlCfRXN6iojIvvaEpuV0pkz5PB2PYt3FuvpNg==
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr4433034ljm.241.1574279176045;
        Wed, 20 Nov 2019 11:46:16 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u12sm74931lje.1.2019.11.20.11.46.15
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 11:46:15 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id n186so498139lfd.11
        for <linux-api@vger.kernel.org>; Wed, 20 Nov 2019 11:46:15 -0800 (PST)
X-Received: by 2002:a19:4949:: with SMTP id l9mr4313293lfj.52.1574279174744;
 Wed, 20 Nov 2019 11:46:14 -0800 (PST)
MIME-Version: 1.0
References: <CAJKzgVtzD7ULwCDVRSLMCmGJNaMqvx+jVO619t3xuv2oiEsPMQ@mail.gmail.com>
 <20191119095708.GB21113@dhcp22.suse.cz> <201911201032.67566C6BF@keescook>
In-Reply-To: <201911201032.67566C6BF@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Nov 2019 11:45:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjw=fg5WznKfA+NQP78h8qDkF=t3CzH96fACAfULza_hQ@mail.gmail.com>
Message-ID: <CAHk-=wjw=fg5WznKfA+NQP78h8qDkF=t3CzH96fACAfULza_hQ@mail.gmail.com>
Subject: Re: Suggested Patch is not working for 22851 Bugzilla issue
To:     Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Bala S <balas2380@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 20, 2019 at 10:39 AM Kees Cook <keescook@chromium.org> wrote:
> Yes, as Michal mentions, there were legitimate binaries that expected to
> overlap mappings

I'm not sure they were really overlapping as much as "the ELF sections
were in a bad order and we don't do the whole "optimize loading"
thing.

It's one of those things that *might* be fixed by first creating a
"simplified/combined map of the ELF sections", and them using mmap()
on that simplified one. But that code is nasty and hairy.

             Linus
