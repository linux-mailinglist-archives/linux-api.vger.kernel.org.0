Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447E423C224
	for <lists+linux-api@lfdr.de>; Wed,  5 Aug 2020 01:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHDXTw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Aug 2020 19:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgHDXTv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Aug 2020 19:19:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F65C06174A
        for <linux-api@vger.kernel.org>; Tue,  4 Aug 2020 16:19:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so4122244wmj.5
        for <linux-api@vger.kernel.org>; Tue, 04 Aug 2020 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=gAGQPSeE7HOwYwavskE5e9li4T5ni5I6TXg1XHHwgN0=;
        b=WPxUM0WXJAqX70CnKHXwSAw6SLBA0tjh5wqt9BwMn7NfOrSH4zv91DCCrdgZbkUCy0
         4Z7WBknUvGKz9/zE6mQo1u8zoXZWVBP5d/bwLfL95ljCYgZebShd0INFvd4xZFd/l2Wi
         vDgos+ut0ON/Ebkas11h7+7DaITTtOBmyZvmlTDhI2sKWemQuDDoXhRvb/OrcYe68p2m
         dWLRjn7VhsL6EaWoriKN+XhUcitsDc25ku1V1kZ3BPD6d6QqO4F0vPQnlGWhPjYF/pYG
         GPaObdb08fsgzOmWqc+5pdL/8zwz8pmHNKIPch8xLM/k3Vw44X+/zIkjPu/GHl++kpBQ
         kO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=gAGQPSeE7HOwYwavskE5e9li4T5ni5I6TXg1XHHwgN0=;
        b=hd7IX0O4eks/6Ja8NPfPp6SXxLH8v4zqXhrTV4NEfZhkporz7trZCQKoH+wT4mv3BQ
         C6NrD+cINYfn5KuaXxtRhyhJqMrsXLGPuMzWryZE2N6wCrHPiHzeNvbXoyQH7EorvMeL
         TrRbgZLxDQmygoJGPZMzUoPn0uf9LIuaY2Txh+h0qAwsa/b1FS6ao4H+gZJ1kwxTUNpu
         HeyC1d0RY8mTcVTIpHFlM1uIfHRFqjcudcGt3VhbvkIdt9aAtwnwQFqJ8oLYL+cWwN5R
         UzYkMNFonTic1y5mcAv9byEKhcRgYjjvzc4kjkgc8VvaRsJZe7rwhxwoYrdbTgtBDaxj
         muTA==
X-Gm-Message-State: AOAM531vk6j6zl1p3HXT1GA6dtU3lG168+cgDTbENCbjF2qjXJ7B8jns
        aBnPg5ZPNXySiiWM/r1O9WIePVSKwsA0idEVwDM=
X-Google-Smtp-Source: ABdhPJy5itM0uqxqd1aXxUA8+zzKNx8l6IvZwgYozHUPG6v9s8UnrtasWDCf/YdJ+Lt5TD4JYBpKuz/4Ixpgz241QBU=
X-Received: by 2002:a7b:c219:: with SMTP id x25mr612543wmi.101.1596583189997;
 Tue, 04 Aug 2020 16:19:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:600c:2f81:0:0:0:0 with HTTP; Tue, 4 Aug 2020 16:19:47
 -0700 (PDT)
Reply-To: sararrobrt@gmail.com
In-Reply-To: <CAGLt2FLbNf72-KaqGgMMYYNwHwfnR55yaHg-QwRV+xHZwATSLA@mail.gmail.com>
References: <CAGLt2FLGpXd62_JsfsuLfs2Sc_GkOs6hSDu6JZT60BaskRhtLQ@mail.gmail.com>
 <CAGLt2FJHZMFKp7v6FCR9DSdHMY+CgY56po9aSYNdF1T5prZ_6A@mail.gmail.com>
 <CAGLt2F+M4ct4jKmDP=0bvSfVNtx2=+aZ2uQJksfCmzJcV1wsNA@mail.gmail.com>
 <CAGLt2FKktjErbUpDQm0y21=tZaUa1HXEuPpmXpt7=oSYvvkBCg@mail.gmail.com>
 <CAGLt2FJ15tS=d4h-CSHEkbNVoh6mPspb47a0AQ5NJm9Lk3vOHw@mail.gmail.com>
 <CAGLt2FLSB4q14ccg-EP-yBOj7dpwVtqwp5FtUBUgrTgruN3ZhA@mail.gmail.com>
 <CAGLt2FJd3_MhiG9WDVKMEaKj+mnAA1QmofzDYLJ7UprjD1dMrQ@mail.gmail.com>
 <CAGLt2FKiq=2Dk9wNk9VNSWbPECdQNZLaCKDaARSeXP6Yc9hOdg@mail.gmail.com>
 <CAGLt2FKDT-=G+Ea1ee833jweyEoW4bB9fY-kcjkVozmQ+khUEw@mail.gmail.com>
 <CAGLt2FJCNLqE9C-4Rw3byTSpPDQJ1eOunA2c9SAy7FSereppeA@mail.gmail.com>
 <CAGLt2FJBQ49yENg2PQnHZBbYD8CM882_tBRebC_LFX=fjRx3jg@mail.gmail.com>
 <CAGLt2FLLnz=AZNDV=5vUCq=O7rYPyKXS7duLLv2wp7qzgvgp2Q@mail.gmail.com>
 <CAGLt2FJPSXK=uC0EnTb+s+FVDpRPe4V9QwvNfxQGS1ELAtXnEA@mail.gmail.com>
 <CAGLt2FKqK6qgT1vi=QVWRUzBgRd0z28f+7CUhNeiBaM0CQYjzA@mail.gmail.com>
 <CAGLt2FL4CCvqbkagaPPiRP98BWxH_J5ROE-YxOSNzfC=reZYWQ@mail.gmail.com>
 <CAGLt2F+6XkX3f2k4TNgnwWexGz_EW=5JWrJfc-pa7GFd9YDWpA@mail.gmail.com>
 <CAGLt2FKTo53eqrfJxppw3h45dnuU1MRmz2_sXgQus-g51_TEaw@mail.gmail.com>
 <CAGLt2FJ+dAHf46fLDmDPxSf-2tjmpXEhF-NpgN4Y=GLSFx=K3g@mail.gmail.com>
 <CAGLt2FL3BSQ5z_y1TfRE9HN1+Unhq+iak6b4kj736-A2g7ooXA@mail.gmail.com>
 <CAGLt2FLgTeRNGdEwGBU3omgWEh0bCqt17Y++aMY_mpGpdEEBGg@mail.gmail.com>
 <CAGLt2FJ-2avNCJcFPb_dpc-ArXWoUrqWLsyxuR2+FPpKubsnHw@mail.gmail.com> <CAGLt2FLbNf72-KaqGgMMYYNwHwfnR55yaHg-QwRV+xHZwATSLA@mail.gmail.com>
From:   "Mrs. Sarah Robert" <mrs.celiliaushaw@gmail.com>
Date:   Wed, 5 Aug 2020 00:19:47 +0100
Message-ID: <CAGLt2FLMKVgi272gkrXhs022QddeZYokbYPZ87BFNFeDa0B3OQ@mail.gmail.com>
Subject: Greeting?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

My Dear,
I'm Mrs. Sarah H. Robert, 77 years old dying widow from Australia;
that was diagnosed of cancer about 4 years ago. I got your details
after an extensive online search Via (Network Power Charitable Trust)
for a reliable person,  I have decided to donate my late husband WILL
valued of ($5,500,000,00) (Five Million Five Hundred Thousand United
States Dollars) to you for charitable goals. Get back to me if you
will be interesting in carrying out this humanitarian project, so that
i can arrange for the release of the funds to you for the work of
charity before entering the surgery theater. Contact me via
E-mail at :  sararrobrt@gmail.com
Sincerely,
Mrs. Sarah H. Robert.
