Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56297214294
	for <lists+linux-api@lfdr.de>; Sat,  4 Jul 2020 03:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgGDBdN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 21:33:13 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:9735 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgGDBdM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 21:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593826393; x=1625362393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZOA5jNuhD7ergwOgohOsatx92Oagwl7YS30ee6JkJY=;
  b=eK3DoNmWR/pmhSrIPQ42coUKAdzXir0k3htL+AzGS2a2tv+vON5HodAK
   ui7nsxpg/2ggt2o0DdYn8v93OKzrQLxNrA4phGwRVOOAU3ekRNani3X7Y
   RDY/kIkpN8Bm2Inv9qdSjC2X9yzUypTnCAfw5rOy2Mro1DkTh1MPx68S4
   A=;
IronPort-SDR: 8fE+uRAOvSYpKn58tAwfs4W0gGeiSnr+xNekpJsrtft03Rk7Yrr72AOHYjFAgNChxct5cyLC7G
 PQ7pNZ1qED3g==
X-IronPort-AV: E=Sophos;i="5.75,309,1589241600"; 
   d="scan'208";a="55965210"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 04 Jul 2020 01:33:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id BDF432850D9;
        Sat,  4 Jul 2020 01:33:07 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 4 Jul 2020 01:33:07 +0000
Received: from [192.168.1.11] (10.43.160.48) by EX13d01UWA003.ant.amazon.com
 (10.43.160.107) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 4 Jul
 2020 01:33:06 +0000
From:   Colm =?utf-8?q?MacC=C3=A1rthaigh?= <colmmacc@amazon.com>
To:     Jann Horn <jannh@google.com>
CC:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-api@vger.kernel.org>, <akpm@linux-foundation.org>,
        <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <mhocko@kernel.org>, <fweimer@redhat.com>, <keescook@chromium.org>,
        <luto@amacapital.net>, <wad@chromium.org>, <mingo@kernel.org>,
        <bonzini@gnu.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date:   Fri, 3 Jul 2020 18:33:05 -0700
X-Mailer: MailMate Trial (1.13.1r5671)
Message-ID: <5E780027-A6A7-4ED3-AA76-16C2036FF8D4@amazon.com>
In-Reply-To: <CAG48ez2CpHX9i3YgkNyMHPz63ohjkaSZscMtwSHOFYN4VQow3Q@mail.gmail.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <CAG48ez2CpHX9i3YgkNyMHPz63ohjkaSZscMtwSHOFYN4VQow3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D36UWB003.ant.amazon.com (10.43.161.118) To
 EX13d01UWA003.ant.amazon.com (10.43.160.107)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 3 Jul 2020, at 4:04, Jann Horn wrote:

>>  - Provides a simple mechanism to avoid RAM exfiltration during
>>    traditional sleep/hibernate on a laptop or desktop when memory,
>>    and thus secrets, are vulnerable to offline tampering or 
>> inspection.
>
> For the first usecase, I wonder which way around this would work
> better - do the wiping when a VM is saved, or do it when the VM is
> restored? I guess that at least in some scenarios, doing it on restore
> would be nicer because that way the hypervisor can always instantly
> save a VM without having to wait for the guest to say "alright, I'm
> ready" - especially if someone e.g. wants to take a snapshot of a
> running VM while keeping it running? Or do hypervisors inject such
> ACPI transitions every time they snapshot/save/restore a VM anyway?


Just to answer this - I’d expect wipe-after-save rather than 
wipe-on-restore to be common for some. That provides the most defense 
against secrets ending up on disk or some other durable medium when the 
VM images are being saved.

-
Colm
