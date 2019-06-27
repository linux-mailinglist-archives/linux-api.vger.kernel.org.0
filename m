Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DAA578C9
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 02:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfF0A5R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Jun 2019 20:57:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33434 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfF0A5R (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Jun 2019 20:57:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so301280plo.0
        for <linux-api@vger.kernel.org>; Wed, 26 Jun 2019 17:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LOqNQI21WoQcwYikAA338UXv4HjPjIDxoN7IITALykc=;
        b=X0d5GBAK8fK3O1X54m92nl3behZ4WkA/8rV8RX5Ok/bv5+gjj7TMhXgRomRfzmVOXD
         em7ihIuuOu8zwEQfQr2BPr16kqr9nG867z+NiKngOGpFvNFT/spb6jGVJWyJdJ7rkQ9u
         TELHm8suVWrXYp0yvohWF90V0gfH4/VNgsZomFmfiVb+mXH+liZvjCk5RIxAZ90Cnldg
         6StHzBNsrbQcUZLntbfJ6eU3EO8aQp/RAVJiM50g2uCqMcTTCSAVhUMML5PXbnLgAdhD
         IqT3E5gyZuP7YeWgiEP/tDnYSLKD/01YRoFXju5YR+B0DiF4BaBbK1Fut9PRZDNCuSjj
         tatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LOqNQI21WoQcwYikAA338UXv4HjPjIDxoN7IITALykc=;
        b=pBkbvT5fW8RQcilsZFh0qWQqK6IvpS4TykhzUHS/TIt2l4tIo98Eaml9DVL5YwOQxD
         L3akrcRXr5fWnyGpvoHmTdaXwTOxaWCKpkrmxn8qZmWib5BqriAc7o1IE8HZ//5VnuNS
         5YnKZs9CTnz+6QdueZAYKLo9IQWIP15S66Y90RE1VGs8YH227NoRH8b25jc8z+wBLXq4
         jiDKXc65/trn0ZKnCCwafQXlsUInd0wLFrhhlLlhZQtaQFFNADXo+DYl39qqfu+Mvjia
         2m2dkbBPdUg9tvngR7dbdmxq7WTpg8Vf3NXeK6JEig0uiwnRKv7gkqU6pCOW3b2Oqely
         V2/A==
X-Gm-Message-State: APjAAAUVNyHs46NSmlM2hd99bxXaLbAaAhXQ618HjCEzejYUrZTXntU4
        U8UqRgtNYs8N4q0Ka6dXhHTyyg==
X-Google-Smtp-Source: APXvYqyTSY9gch65Qu9dGOhZGNTvsfd+ZezV4tkSiG14HtuietLqII750U3Ph8OeSOTNoq+MuoK8rA==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89mr1102632pld.77.1561597036529;
        Wed, 26 Jun 2019 17:57:16 -0700 (PDT)
Received: from [100.74.181.2] (35.sub-174-215-8.myvzw.com. [174.215.8.35])
        by smtp.gmail.com with ESMTPSA id w10sm299843pgs.32.2019.06.26.17.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 17:57:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V33 24/30] bpf: Restrict bpf when kernel lockdown is in confidentiality mode
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <alpine.LRH.2.21.1906270621080.28132@namei.org>
Date:   Wed, 26 Jun 2019 17:57:12 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        linux-security@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-security-module@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E53376F-01BB-4795-BC02-24F9CAE00001@amacapital.net>
References: <20190621011941.186255-1-matthewgarrett@google.com> <20190621011941.186255-25-matthewgarrett@google.com> <CALCETrVUwQP7roLnW6kFG80Cc5U6X_T6AW+BTAftLccYGp8+Ow@mail.gmail.com> <alpine.LRH.2.21.1906270621080.28132@namei.org>
To:     James Morris <jmorris@namei.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Jun 26, 2019, at 1:22 PM, James Morris <jmorris@namei.org> wrote:
>=20
> [Adding the LSM mailing list: missed this patchset initially]
>=20
>> On Thu, 20 Jun 2019, Andy Lutomirski wrote:
>>=20
>> This patch exemplifies why I don't like this approach:
>>=20
>>> @@ -97,6 +97,7 @@ enum lockdown_reason {
>>>        LOCKDOWN_INTEGRITY_MAX,
>>>        LOCKDOWN_KCORE,
>>>        LOCKDOWN_KPROBES,
>>> +       LOCKDOWN_BPF,
>>>        LOCKDOWN_CONFIDENTIALITY_MAX,
>>=20
>>> --- a/security/lockdown/lockdown.c
>>> +++ b/security/lockdown/lockdown.c
>>> @@ -33,6 +33,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY=
_MAX+1] =3D {
>>>        [LOCKDOWN_INTEGRITY_MAX] =3D "integrity",
>>>        [LOCKDOWN_KCORE] =3D "/proc/kcore access",
>>>        [LOCKDOWN_KPROBES] =3D "use of kprobes",
>>> +       [LOCKDOWN_BPF] =3D "use of bpf",
>>>        [LOCKDOWN_CONFIDENTIALITY_MAX] =3D "confidentiality",
>>=20
>> The text here says "use of bpf", but what this patch is *really* doing
>> is locking down use of BPF to read kernel memory.  If the details
>> change, then every LSM needs to get updated, and we risk breaking user
>> policies that are based on LSMs that offer excessively fine
>> granularity.
>=20
> Can you give an example of how the details might change?
>=20
>> I'd be more comfortable if the LSM only got to see "confidentiality"
>> or "integrity".
>=20
> These are not sufficient for creating a useful policy for the SELinux=20
> case.
>=20
>=20

I may have misunderstood, but I thought that SELinux mainly needed to allow c=
ertain privileged programs to bypass the policy.  Is there a real example of=
 what SELinux wants to do that can=E2=80=99t be done in the simplified model=
?

The think that specifically makes me uneasy about exposing all of these prec=
ise actions to LSMs is that they will get exposed to userspace in a way that=
 forces us to treat them as stable ABIs.=
