Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588CC39AAE8
	for <lists+linux-api@lfdr.de>; Thu,  3 Jun 2021 21:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFCT1o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Jun 2021 15:27:44 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:34598 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCT1o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Jun 2021 15:27:44 -0400
Received: by mail-pf1-f170.google.com with SMTP id g6so5673502pfq.1
        for <linux-api@vger.kernel.org>; Thu, 03 Jun 2021 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VKOvv1TfivesDpA9bfyoNG/IGgKCAjb7/e1zzaiAOEk=;
        b=YHJtOqmPmvkFRQD2wSYjf5pEKJlBfTPGaQOnmvD/5Z9Y4F5422uvqf19ecqh+AZHI8
         yAVvX4M8R1gI6PVHLKRqdskhOY3wedR4+hxBr18GaFfPA/pR52s6ev3ZvjQj8A45N1Fx
         U389vkuek419vpSY0Lgx/aC0pjQ6UHGKHXs0wAy1tUHt/hVdhxBn1Xmt3Q0vDEEbk2gt
         rSmuBEXFguqfGN2nqGbExMh2omMlRV9s8qDzIsBBpxkKAdz9Jrdi5vmtaaZtw//SVwNO
         gaQTYGHkxnc/EpICvm1ylvW4QsOvmk05/ZVNMKMo3HBcx3RqJv3RtxBueIbs2U8JMwGH
         PRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VKOvv1TfivesDpA9bfyoNG/IGgKCAjb7/e1zzaiAOEk=;
        b=Sw39UaYGpV2fE6wqqRf8f7jSnLFKRDjiSSwqWtYT22fddWmnUNkcqVR9+INVCLtN8M
         2vY+bF15TYwrHCh2x6NDDjRdvPlze76AfIjaBUdPfdw6Au+c2GND+3WfrbeDOKAMx8JA
         wcuy+L0LhlcEXVoFvtzArwpblubClhbqpwfe8lPBvdUp+Yc4Pdg6+pq/RC6KBqqkSCv5
         ldHI8EE00axla+00pE4Vl96yGuKZ1kDSACTV4ztJMHpbqirVT8FMTBjeM0ISBb/O2cOL
         aVpNrJzJTm8xxeHQU5bPurRXQQALHTMUi91zNMQRR+F80ALsgZ9ZVUBw+gDWo4Wuktaz
         uQ8A==
X-Gm-Message-State: AOAM532WD6Zv+hpxvzxhw0JWCbn7ZcmwXQrq4LSBB96hfvTyK1LQBRAn
        MBJvNkR7RmgLPL0zCHZDm8oRTA==
X-Google-Smtp-Source: ABdhPJy1l1e1qBBumUKmmUFg1ps6/AplTMQguP1JhPTC2mJ0/V2yYMHkrXdmtj1HUyX2mi7TcLfapw==
X-Received: by 2002:a62:2e04:0:b029:2db:4c99:614f with SMTP id u4-20020a622e040000b02902db4c99614fmr575083pfu.47.1622748299253;
        Thu, 03 Jun 2021 12:24:59 -0700 (PDT)
Received: from smtpclient.apple ([2600:1010:b04a:17e9:b873:a3cc:f7b1:9d6d])
        by smtp.gmail.com with ESMTPSA id n23sm3300321pgv.76.2021.06.03.12.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:24:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
Date:   Thu, 3 Jun 2021 12:24:56 -0700
Message-Id: <1FD047D2-F5F3-4AC6-A4E4-DB8FB1568821@amacapital.net>
References: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Ming Lin <mlin@kernel.org>,
        Simon Ser <contact@emersion.fr>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (18E212)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Jun 3, 2021, at 12:14 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Thu, Jun 3, 2021 at 12:07 PM Hugh Dickins <hughd@google.com> w=
rote:
>>=20
>> But the point that we've arrived at, that I'm actually now fairly
>> happy with, is do *not* permit MAP_NOSIGBUS on MAP_SHARED mappings.
>=20
> Yeah, if that's sufficient, then that original patch should just work as-i=
s.
>=20
> But there was some reason why people didn't like that patch
> originally, and I think it was literally about how it only worked on
> private mappings (the "we don't have a flag for it in the vm_flags"
> part was just a small detail.
>=20
> I guess that objection ended up changing over time.
>=20
>=20

I don=E2=80=99t understand the use case well enough to comment on whether MA=
P_PRIVATE is sufficient, but I=E2=80=99m with Hugh: if this feature is imple=
mented for MAP_SHARED, it should be fully coherent.=
