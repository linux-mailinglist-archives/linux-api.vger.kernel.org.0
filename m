Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5534B3509AC
	for <lists+linux-api@lfdr.de>; Wed, 31 Mar 2021 23:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhCaVmh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhCaVmW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Mar 2021 17:42:22 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9CCC061574;
        Wed, 31 Mar 2021 14:42:21 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id h34so6607952uah.5;
        Wed, 31 Mar 2021 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ocallahan-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Dm0wbOpFh785zQvfbpu+Gc+GoqlFqm/RgMC8mqoD454=;
        b=WErKMdfwEEzxHs7ggw/O2PQZpwoXB2Iotis7qJYEo0LRMCZXsa+qYkwiSOCFmPYHSa
         Liu6m1KZBi2RPMTFSN6sNzBiRYruN286prnZ5ftunCiK7tKu5bIHt7mBwhOZ+H7HTnQF
         AKw0Au9LcsoOAs4NgfVmrL8a+W37Ub2+pqsY//5W3xDYPFdqHmnlsRvQamuZLFdncL2z
         YjmXe8tXjicjVLSxR0u/VH82Ks94K1sTf8f16ZZnvDYLVWE73Fx/MusoAtKEfKGRqc+q
         4w7yY9ULAMo/gfWNdh0RakFn36LylnUnn4LIU8KJ+f37gOVtSFeTCeaY3Zj+mBqxwgFz
         qLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Dm0wbOpFh785zQvfbpu+Gc+GoqlFqm/RgMC8mqoD454=;
        b=eYWm2KA1pt3qNY1kOOWNzB39qhncuSHTmRy0FvClfgahfshFggpoIw1REbKqCEzcLv
         bHxOEh9DqfVMEKG+YnOm9FeIZrSibPUOmDiBsSy5gfExl8emeLQS6fuDWKwJdMHsdrDu
         mQjYgmijXSJTDuCbX1JGN2zRbDXb29DPFT+MtAJAnkGszQswGEIiNycP27Abiavmz/AR
         e1tOGJa8JFezqRkPxxZZic48Qt6dxQrm5zSpIcgPcIljSfrgSGVU4glUyKVt+cnRWJYU
         9DyAsILY1ZeRQ+RHUIMpZMUMiXHvXsy0pgm8p+cTSXs3H2tPUnIc3r+rFLX3v+mGBDLN
         rUDA==
X-Gm-Message-State: AOAM531+Yy4IDFtbS/mM6V1qp7wEjN5t+4wRZTA0c4kAOvGhh8io/h4U
        6K0QkkLJqiY8WJXZ4HawMGlQjkg20ZGl9WnG+OY=
X-Google-Smtp-Source: ABdhPJzQXGO7xNMfiF+fsWwrOhWMH2IoZPkeQ1c/q0a5akhIsplUSQbq7ZQS2Km1iImMQjHLVJxaxaOJ6yhhEwdPiGs=
X-Received: by 2002:ab0:4042:: with SMTP id h60mr3070914uad.133.1617226940932;
 Wed, 31 Mar 2021 14:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net>
In-Reply-To: <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net>
Reply-To: robert@ocallahan.org
From:   "Robert O'Callahan" <robert@ocallahan.org>
Date:   Thu, 1 Apr 2021 10:42:09 +1300
Message-ID: <CAOp6jLb6OwfaBcYsdRZ-A5FLpY+y7WNoBqwc+2oCP7-3Sy-ZHg@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Len Brown <lenb@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

For the record, the benefits of dynamic XCR0 for rr recording
portability still apply. I guess it'd be useful for CRIU too. We would
also benefit from anything that incentivizes increased support for
CPUID faulting.

Rob
--
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.
