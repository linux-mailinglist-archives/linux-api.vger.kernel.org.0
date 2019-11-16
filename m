Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D5FF0FE
	for <lists+linux-api@lfdr.de>; Sat, 16 Nov 2019 17:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfKPQJN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 16 Nov 2019 11:09:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33362 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbfKPQJN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 16 Nov 2019 11:09:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so6851607plb.0
        for <linux-api@vger.kernel.org>; Sat, 16 Nov 2019 08:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=rbbVOSmMuRnIGDknBjXXfC0fBPASDKYoYUrmo5eNFgM=;
        b=bS92H15s+5qWORaPy/KpGyd9SsgC655KqQYuSsU9pKNGfk9SJTLqRih+4XIq+ZkOS2
         +/poIX3KAggHJsmIL0jJM+EurfmUKZRoJ9Bb5rc9SAaN4mUnuVL0u4psU6cMne+FN7vp
         37n6UpKt+0TZ3XSqaIb7jbEgq6pL0UEzQ6MkRCpb5Id5hwADu+fONtfsT2zYci08+irc
         miWPM6cogv/xFmoqjRR41ZkQlbnm7Oql0Oxp4oS3u9d+DJyiLsEyCDgbacdlxGsCwHWr
         ZGwZtccBiL2U/y9DsrLyrdaGrRPsceSG8ipedytZVQBCAmEN0NK/dNnPTzzBSvM1VLxH
         9XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=rbbVOSmMuRnIGDknBjXXfC0fBPASDKYoYUrmo5eNFgM=;
        b=ai1gcOtyJINP0/F86X/04p09dG768zUDPlazMN7l8n1PzEZ74THPbQjKnqHsAHFJb1
         OXZS4Y7NYBiMg0Z2Bq+iPpSe6JU21bVpRvshwtc61vQxIbfHLtjmuWZ1cUgpykhg2FW9
         ZejXyTp8B4ahFfK0zJofSvlaIvinbTTj7MAw7ME8ThX5Wvi2jTpz481A4GlqKUWRv/EH
         ZmIDermnUD7jekPksMDY+g/EGW1NxXCM6IVXOlo6BItdW4/8TlIJgONdz+mACqEr+OFF
         MEi60C8hL7TjfZhnaCihPvfzzw9dcLY6OvP+SYFQP0dQMTJy9CGw6eW2P3md7jX09az+
         WwtA==
X-Gm-Message-State: APjAAAUDFcBoiq1NitnEJiSvMAIFcsrYDWEIaniiYYaaUxCDmaEf+vWW
        z4OHVcP3iSq/yacYV1yPsKdMnik2m1FPSg==
X-Google-Smtp-Source: APXvYqzE6Pi8rl2FiPhLgHMfAfWxumnilALnvG8Q4I2VlRDOhJtY5abcO5MMFPuq46JoQGSuS01GjA==
X-Received: by 2002:a17:90b:3015:: with SMTP id hg21mr27434228pjb.96.1573920552189;
        Sat, 16 Nov 2019 08:09:12 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:28e6:fc7a:c382:8b6f? ([2601:646:c200:1ef2:28e6:fc7a:c382:8b6f])
        by smtp.gmail.com with ESMTPSA id r33sm13936396pjb.5.2019.11.16.08.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2019 08:09:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v25 10/12] LRNG - add TRNG support
Date:   Sat, 16 Nov 2019 08:09:09 -0800
Message-Id: <DDB907EA-3FCC-40C7-B55B-A84BC77FD7A1@amacapital.net>
References: <5390778.VeFRgus4bQ@positron.chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
In-Reply-To: <5390778.VeFRgus4bQ@positron.chronox.de>
To:     =?utf-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
X-Mailer: iPhone Mail (17A878)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.de> wro=
te:
>=20
> =EF=BB=BFThe True Random Number Generator (TRNG) provides a random number
> generator with prediction resistance (SP800-90A terminology) or an NTG.1
> (AIS 31 terminology).
>=20

...

> The secondary DRNGs seed from the TRNG if it is present. In addition,
> the /dev/random device accesses the TRNG.
>=20
> If the TRNG is disabled, the secondary DRNGs seed from the entropy pool
> and /dev/random behaves like getrandom(2).

As mentioned before, I don=E2=80=99t like this API.  An application that, fo=
r some reason, needs a TRNG, should have an API by which it either gets a TR=
NG or an error. Similarly, an application that wants cryptographically secur=
e random numbers efficiently should have an API that does that.  With your d=
esign, /dev/random tries to cater to both use cases, but one of the use case=
s fails depending on kernel config.

I think /dev/random should wait for enough entropy to initialize the system b=
ut should not block after that. A TRNG should have an entirely new API that i=
s better than /dev/random.
