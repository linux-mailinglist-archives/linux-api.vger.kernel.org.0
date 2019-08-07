Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E3284DE8
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2019 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfHGNwk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 09:52:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41092 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbfHGNwk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 09:52:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so40785592pls.8
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QnyCTyMbm52NNTF3jvsG/XFHwGBN7xSjxw+ALsjB1gk=;
        b=hvFXtVNZhyN0kdv9iaA7yZN5RqEBCjciXVvNLIybGo9HT7b3b+wEhDXgwXt9UF8Mrn
         eZN37QzXBNaCRPUTOtvLbduEWeOl25BDcGmYWV9ZLZmyIY2DelXEGI0guJ8ZqYDWCUc+
         Uq07GDbvjCnmuho1/UwA+WeZD6IjYNeymq8uFSzW05d1Kn5WjcoE/sdiEk4q9Pnv4DZG
         rGzgQi4Dw5txGWJVOLLOOxkaXvyGLKhZ4QawFZhVwDTHvgFIyA6iWIhIz3gscwe8DFor
         gFkbJ3pleEF/BzQx06R1m0tmzKsGUUbphwQkDn43e/6Z8P/hMPwnuj+yzSMhfPUJT3ph
         I76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QnyCTyMbm52NNTF3jvsG/XFHwGBN7xSjxw+ALsjB1gk=;
        b=BEUQJowQG3P19NhccGXDu7zPfVOlZhLVM/5pYZfdXyEGJrAOi8w8agim6kENfC0rY2
         zrC8V9X2aOFjDuKp1Bks9XQmMSR41GdC3x5+Knr8IAXfjFPkyKyMe7MJNtISHIoElV7p
         IVwiIPVwJ3GMrmCkU6jA0RVoHzw+e/kglbxPJCwr9BZwdb6jtFkHiFRDZtH/V70qRrbR
         oWgejPT20o5g2r4EybKn+bZkXA4t+2w6ynwoVBiGeUunR2UZF6rRPd7Xwh/eNMZjnZ2q
         x6/jqgKyB7ffu1CLXHyhM+4L8AcGsaChSviFSXLOPKGg1BLficaAeGWEjqH4GksLnrZg
         Dc8A==
X-Gm-Message-State: APjAAAUJxRJbVh+V/ntiuMZvwi4qu5U9RRyA+vmbBB2O2zulMwMT92Eo
        Dp6LhFw5TJYJ/eJOWGoh/xVDrM9bk/U=
X-Google-Smtp-Source: APXvYqyZHqBPVgXKeTfuam/+wr//DWw1+la2CyEt/5QA6T/uZGoDWyT0btIOkYHc/WOyvZTCa5PcRg==
X-Received: by 2002:aa7:9dcd:: with SMTP id g13mr9657897pfq.204.1565185959443;
        Wed, 07 Aug 2019 06:52:39 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:e49d:f1dd:cb7c:c8f6? ([2601:646:c200:1ef2:e49d:f1dd:cb7c:c8f6])
        by smtp.gmail.com with ESMTPSA id q69sm130734pjb.0.2019.08.07.06.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 06:52:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <CACAyw9_fVZFW_x4uyTAiRfeH6oq1KHv0uB2wO84u5JZyD+Unaw@mail.gmail.com>
Date:   Wed, 7 Aug 2019 06:52:36 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <945BCF23-839C-418C-9FBF-46889AE84CA4@amacapital.net>
References: <D4040C0C-47D6-4852-933C-59EB53C05242@fb.com> <CALCETrVoZL1YGUxx3kM-d21TWVRKdKw=f2B8aE5wc2zmX1cQ4g@mail.gmail.com> <5A2FCD7E-7F54-41E5-BFAE-BB9494E74F2D@fb.com> <CALCETrU7NbBnXXsw1B+DvTkfTVRBFWXuJ8cZERCCNvdFG6KqRw@mail.gmail.com> <CALCETrUjh6DdgW1qSuSRd1_=0F9CqB8+sNj__e_6AHEvh_BaxQ@mail.gmail.com> <CALCETrWtE2U4EvZVYeq8pSmQjBzF2PHH+KxYW8FSeF+W=1FYjw@mail.gmail.com> <EE7B7AE1-3D44-4561-94B9-E97A626A251D@fb.com> <CALCETrXX-Jeb4wiQuL6FUai4wNMmMiUxuLLh_Lb9mT7h=0GgAw@mail.gmail.com> <20190805192122.laxcaz75k4vxdspn@ast-mbp> <CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com> <20190806011134.p5baub5l3t5fkmou@ast-mbp> <CALCETrXEHL3+NAY6P6vUj7Pvd9ZpZsYC6VCLXOaNxb90a_POGw@mail.gmail.com> <CACAyw9_fVZFW_x4uyTAiRfeH6oq1KHv0uB2wO84u5JZyD+Unaw@mail.gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Aug 7, 2019, at 2:03 AM, Lorenz Bauer <lmb@cloudflare.com> wrote:
>=20
>> On Wed, 7 Aug 2019 at 06:24, Andy Lutomirski <luto@kernel.org> wrote:
>> a) Those that, by design, control privileged operations.  This
>> includes most attach calls, but it also includes allow_ptr_leaks,
>> bpf_probe_read(), and quite a few other things.  It also includes all
>> of the by_id calls, I think, unless some clever modification to the
>> way they worked would isolate different users' objects.  I think that
>> persistent objects can do pretty much everything that by_id users
>> would need, so this isn't a big deal.
>=20
> Slightly OT, since this is an implementation question: GET_MAP_FD_BY_ID
> is useful to iterate a nested map. This isn't covered by rights to
> persistent objects,
> so it would need some thought.
>=20
>=20

A call to get an fd to a map referenced by a map to which you already have a=
n fd seems reasonable to me. The new fd would inherit the old fd=E2=80=99s a=
ccess mode.=
