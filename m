Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91432266943
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKT4q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 15:56:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51970 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725794AbgIKT4n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Sep 2020 15:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599854201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiRrxuwpYWnQMo5FTx+dqZUh/zO6pDjeXZnxQ5ttgXM=;
        b=hSEYd+1AX1WQ+YoMstjzmjnPZisJz2UzQ//XsHPW/ZmPbjydd8m8avEWEdhM2CKaageOTj
        Pl4ADpE9uvKWmlAuiPJuPsmYC97i7Nl++LOAsJ+k0IAxJMrDxzYz7RQgf9E9fOod2MANc/
        dzZfP7AYIdQ1WY1mUF3Qg/Npbr3bJNk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-iLX0Ud5ENJ2mNozesrOD0A-1; Fri, 11 Sep 2020 15:56:39 -0400
X-MC-Unique: iLX0Ud5ENJ2mNozesrOD0A-1
Received: by mail-ed1-f70.google.com with SMTP id bm14so5392536edb.2
        for <linux-api@vger.kernel.org>; Fri, 11 Sep 2020 12:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HiRrxuwpYWnQMo5FTx+dqZUh/zO6pDjeXZnxQ5ttgXM=;
        b=XqtBCseSgcH01sU8rE3EWSOinKgq4a7EzX/JlPB7hpm8oEW0gn+hfl3S44NucqstHj
         OP8TVh0p50LoGT5JsXItk8a+sOgjxEjcTb23hl3VTbDNa3c2mqZktNarKvG1oXPCTqpB
         AuL7+pOjI5Gwn/d53AxC3xLzjseSS9LAwK4CKemWzD8/gI/S4LIqjXbD0fZ+qn5mY6k7
         jRwIB791ySmMimM6uOwvoaE66IIzOYwmhnqM0HvvDAFyUt7tDFL+H5EB3bA4fvKqgVxK
         DWMOqPL7LxjtOklcSG629lw28ZXlcpcDfEvZQSoSkIqH7bB3zLeq+xWt/Ha61mEzoot6
         13Ew==
X-Gm-Message-State: AOAM533YrK/FqTpM9xw556T721LycB4J5E3DOoWMKN1mHQK6A24ZqTIf
        So2Dy3KnEZ49n5keAFl++6QMC/c04rD6jUqGb6dEXbwXnCtK03fofxCUoswm5ISlUBiEZCUegg7
        YJDLA1A5Tn5KWeDnxz4ny
X-Received: by 2002:a17:907:264c:: with SMTP id ar12mr3728411ejc.80.1599854198606;
        Fri, 11 Sep 2020 12:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI2PQqNt1dvpjMD5lrK1YjwwLI/bFW1FAJaJVtd+QNRGaoPSJVEC6/DS0aphwnU+mNXyXTeQ==
X-Received: by 2002:a17:907:264c:: with SMTP id ar12mr3728402ejc.80.1599854198424;
        Fri, 11 Sep 2020 12:56:38 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6263.dip0.t-ipconnect.de. [91.12.98.99])
        by smtp.gmail.com with ESMTPSA id e4sm2486542edk.38.2020.09.11.12.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:56:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device ?
Date:   Fri, 11 Sep 2020 21:56:36 +0200
Message-Id: <F078F2C8-989D-4A5A-BCB8-F7E215A795A4@redhat.com>
References: <75611c1b4ab44265acff75aa8754d48f@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
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
In-Reply-To: <75611c1b4ab44265acff75aa8754d48f@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> Am 11.09.2020 um 21:36 schrieb Luck, Tony <tony.luck@intel.com>:
>=20
> =EF=BB=BF
>>=20
>> It's actually really hard to map a DIMM to a physical address.
>> Interleaving can mean that one page actually spans a bunch of DIMMs.
>=20
> Heh! If NUMA mode is turned off your single page may have cache lines
> from *every* DIMM in the system. Even with NUMA turned on the page
> will have cache lines from every DIMM on the socket.
>=20

Thanks Dave and Tony, that=E2=80=98s valuable information!

How would it behave after hotplugging a single DIMM  - I assume a single pag=
e will only be mapped to that DIMM (otherwise a lot of stuff would habe to b=
e moved around. Would the mapping change after a reboot - especially can a D=
IMM that could get hotunplugged before suddenly no longer be hotunplugged in=
dividually?

> -Tony

