Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1F8485A
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2019 11:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfHGJEK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 05:04:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45726 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfHGJEK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 05:04:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so8106489otq.12
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEID4hdTU9OsE5Olv2ITic1w7RC+FwSfy06kTRhmLAU=;
        b=tm3vjwdrSmhydT/BngaZ4D2guziS0KvNUwGsyqlHQwb+vS5LAKappAwNqm16YG4s80
         1iyco+xqoSe9NicXaMOzfQkqvNQ54gDo442yWGxxUrP44xp9u+toJpj5d7lYRyOJxkwN
         Y1+9yQtqXWmVbmzbi49/xNT9OaVoZti+48FQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEID4hdTU9OsE5Olv2ITic1w7RC+FwSfy06kTRhmLAU=;
        b=b4SKWKdc6mOdswQMjwiU7MNO++4hrkystebANpaB2CW917Pv4uR1MemGMeu5R/9/QN
         sNAE9sNsJmRB/+6M+uHRdRbGloSvbWGXqCmaUnWIdlhFMSLpbzpNCi2verUs6CGQtxOU
         Cbo0gSFkj0M4D1+x6Z+B39TqgR5pg84g/ka4NaTe6Sh5tnYg6l54WSz1znlefAveL4bQ
         BqbWatB2frgSjk9HNZ4XRmYUw2tMBB8BIqwHa588EVb5tVCqxVnRQ8RgOcOPsnFNjPaz
         lI72RscHZM49S7lfKKTGn4Roa9wpbaqLbvDuMBSez+5O5vQgz/TT/4+v7gz9R+DLa/IG
         /KCQ==
X-Gm-Message-State: APjAAAU0xxGymN5i7X5i2KlOhKj+JYyStEy6sSNnN1nONPUVCIPY+nr6
        5zuK8390BvUMpKIIoOgULmk2RLM16thGlwkClkaZkw==
X-Google-Smtp-Source: APXvYqxo3V1y9sCi7dZxUrDx795buEc6t5ypLDcJyjSBO2fNRxIwTpRSLHtVX8CsTXxFONDTe86DoWRJdEj11+wyvcY=
X-Received: by 2002:a05:6830:1485:: with SMTP id s5mr6423742otq.132.1565168649273;
 Wed, 07 Aug 2019 02:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <D4040C0C-47D6-4852-933C-59EB53C05242@fb.com> <CALCETrVoZL1YGUxx3kM-d21TWVRKdKw=f2B8aE5wc2zmX1cQ4g@mail.gmail.com>
 <5A2FCD7E-7F54-41E5-BFAE-BB9494E74F2D@fb.com> <CALCETrU7NbBnXXsw1B+DvTkfTVRBFWXuJ8cZERCCNvdFG6KqRw@mail.gmail.com>
 <CALCETrUjh6DdgW1qSuSRd1_=0F9CqB8+sNj__e_6AHEvh_BaxQ@mail.gmail.com>
 <CALCETrWtE2U4EvZVYeq8pSmQjBzF2PHH+KxYW8FSeF+W=1FYjw@mail.gmail.com>
 <EE7B7AE1-3D44-4561-94B9-E97A626A251D@fb.com> <CALCETrXX-Jeb4wiQuL6FUai4wNMmMiUxuLLh_Lb9mT7h=0GgAw@mail.gmail.com>
 <20190805192122.laxcaz75k4vxdspn@ast-mbp> <CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com>
 <20190806011134.p5baub5l3t5fkmou@ast-mbp> <CALCETrXEHL3+NAY6P6vUj7Pvd9ZpZsYC6VCLXOaNxb90a_POGw@mail.gmail.com>
In-Reply-To: <CALCETrXEHL3+NAY6P6vUj7Pvd9ZpZsYC6VCLXOaNxb90a_POGw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 7 Aug 2019 10:03:57 +0100
Message-ID: <CACAyw9_fVZFW_x4uyTAiRfeH6oq1KHv0uB2wO84u5JZyD+Unaw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 7 Aug 2019 at 06:24, Andy Lutomirski <luto@kernel.org> wrote:
> a) Those that, by design, control privileged operations.  This
> includes most attach calls, but it also includes allow_ptr_leaks,
> bpf_probe_read(), and quite a few other things.  It also includes all
> of the by_id calls, I think, unless some clever modification to the
> way they worked would isolate different users' objects.  I think that
> persistent objects can do pretty much everything that by_id users
> would need, so this isn't a big deal.

Slightly OT, since this is an implementation question: GET_MAP_FD_BY_ID
is useful to iterate a nested map. This isn't covered by rights to
persistent objects,
so it would need some thought.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
