Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019572669C0
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 22:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgIKUt2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 16:49:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37311 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725811AbgIKUtP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Sep 2020 16:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599857353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPujA0Ryp4LyB06UqeSBwSR2AMMizIQ9L2dC6UhUTSU=;
        b=IW5mWB7pbmzRl0Z+Ej00hdqtEzFvY8XYm+tc7SC/rwiVfN1+NT4lza+Jk7VN2zJ93Cl6e2
        1lWmalJXAKy6z5fQFP9Gn7WfmVXdj5SkUfSKc8tO7Ga+le0zaCavos+yWmq/h06+sVOAu2
        J44iQWBu9Drg8QjW4lUxa8bbjtbEv0g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-wSnFjbXBOjaceZFBayi73Q-1; Fri, 11 Sep 2020 16:49:09 -0400
X-MC-Unique: wSnFjbXBOjaceZFBayi73Q-1
Received: by mail-ej1-f72.google.com with SMTP id li24so5425114ejb.6
        for <linux-api@vger.kernel.org>; Fri, 11 Sep 2020 13:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=fPujA0Ryp4LyB06UqeSBwSR2AMMizIQ9L2dC6UhUTSU=;
        b=RSHfjpptL/ZtvVaxMusGFDJBEcvc1jKI0IEla9WiTxilNYtRvWKZZEvM6wRv/DAM6h
         7swc9Gn/KM5VB29XLbKKSLFNuI7eL1nvKjGArPzr3gXf/kKfArciZ/5pWKJ+bscGBf6Y
         Yt5VCkP8tURN7bEJti+IR8yE0gJvu9ZVxay6LNhmzZmPKfMCQIF1j9Ii27mZ+bnY9VwW
         IEkWIGfU4QyX2rDqH2BAj87fCywOsaHo9VjcjsHHnmOYryhBX0AcZ0UkDbG9IwGvZ0ak
         k5JovpsibiQvytwTA/TUG8gp58xFWSrmxDofCY489Wm9Z+GQNOQQjtaBGab4V3/Xj/vD
         A6VA==
X-Gm-Message-State: AOAM531trg4y8kWMTicwudbhpcdF0oNn64oG4PnZLKRuHek7jbKb4IKx
        LWIB93HXlrFBKBetU+VQ4/bhUrCQDaKejUPehaq+sOkWJn5JriPbzyjRtAsGvYPIPClf5yctN6y
        GXpclwWWYFIPv/RkPBBFw
X-Received: by 2002:aa7:de91:: with SMTP id j17mr4457854edv.85.1599857348683;
        Fri, 11 Sep 2020 13:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE+jQqynUXOKtrNfjmqrI4QDMcdgn1AqBUZfu/2O5MLQVff4P6n5KhdEGMOOZwYcbrX5uJdQ==
X-Received: by 2002:aa7:de91:: with SMTP id j17mr4457832edv.85.1599857348528;
        Fri, 11 Sep 2020 13:49:08 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6263.dip0.t-ipconnect.de. [91.12.98.99])
        by smtp.gmail.com with ESMTPSA id g20sm2586507edh.62.2020.09.11.13.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 13:49:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device ?
Date:   Fri, 11 Sep 2020 22:49:06 +0200
Message-Id: <00BF194F-9B67-4F7B-AA6F-902E2BCB2F7B@redhat.com>
References: <64ad68af6abe4d6b9a346e777e2bd864@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <64ad68af6abe4d6b9a346e777e2bd864@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> Am 11.09.2020 um 22:09 schrieb Luck, Tony <tony.luck@intel.com>:
>=20
> =EF=BB=BF
>>=20
>> How would it behave after hotplugging a single DIMM  - I assume a single p=
age will only be mapped to that DIMM (otherwise a lot of stuff would habe to=
 be moved around. Would the mapping change after a reboot - especially can a=
 DIMM that could get hotunplugged before suddenly no longer be hotunplugged i=
ndividually?
>=20
>=20
> We don't currently have any platforms that would allow hot adding at the D=
IMM level.
> The Brickland generation of E7 Xeon servers (Ivybridge, Haswell, Broadwell=
) allowed
> for hot plugging a riser card that contained up to 12 DIMMs.
>=20
> If you did add memory it would have to appear at the top of the system phy=
sical
> address space. No interleave (unless you added more than one DIMM in a sin=
gle
> operation).  After a reboot the system would likely shuffle things around t=
o and
> interleave.
>=20

Thanks a lot - so I=E2=80=98m really spoiled by hot(un)plug capabilities in v=
irtualized environments :D

> -Tony

