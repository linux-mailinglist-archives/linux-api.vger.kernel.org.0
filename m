Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D8421429A
	for <lists+linux-api@lfdr.de>; Sat,  4 Jul 2020 03:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgGDBpO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 21:45:14 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:42748 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgGDBpN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 21:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593827113; x=1625363113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o3wcxHEUDzo7gzi/qwshOzjZFsEmpc7efi5J9zjp7Gk=;
  b=KutQ1boQ64P+9BSfg6uqCVMxTDsBBKp3LWsX4UsPzmDPU3K/h+93NRk9
   udGKGWROUYADjzaWl7NHu2CHJ1A7SR9IYU5oCaX+7KFmi9ulK3jTaCkJ5
   Sy2bv8nHs6wFpkTRkEx1QqK6sAJOtl8nMPh8dyhAq4xaN4GXJPAyt+do/
   o=;
IronPort-SDR: UBdLufur1lSRpvBgz4Zr4+l47UAnJ/3PWVcYXc8KM7dJDPUarUVWV0+FKRfQE13R/CiyDWuL0R
 EsZIIqZwfY8w==
X-IronPort-AV: E=Sophos;i="5.75,309,1589241600"; 
   d="scan'208";a="57237237"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 Jul 2020 01:45:10 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 9C04AA26CC;
        Sat,  4 Jul 2020 01:45:08 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 4 Jul 2020 01:45:07 +0000
Received: from [192.168.1.11] (10.43.160.100) by EX13d01UWA003.ant.amazon.com
 (10.43.160.107) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 4 Jul
 2020 01:45:07 +0000
From:   Colm =?utf-8?q?MacC=C3=A1rthaigh?= <colmmacc@amazon.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-api@vger.kernel.org>, <akpm@linux-foundation.org>,
        <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <fweimer@redhat.com>, <keescook@chromium.org>,
        <luto@amacapital.net>, <wad@chromium.org>, <mingo@kernel.org>,
        <bonzini@gnu.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date:   Fri, 3 Jul 2020 18:45:06 -0700
X-Mailer: MailMate Trial (1.13.1r5671)
Message-ID: <BC9E44B2-D3C2-43C7-8F4B-A31477147368@amazon.com>
In-Reply-To: <20200703113026.GT18446@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D25UWB002.ant.amazon.com (10.43.161.44) To
 EX13d01UWA003.ant.amazon.com (10.43.160.107)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 3 Jul 2020, at 4:30, Michal Hocko wrote:

> On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
>> This patch adds logic to the kernel power code to zero out contents =

>> of
>> all MADV_WIPEONSUSPEND VMAs present in the system during its =

>> transition
>> to any suspend state equal or greater/deeper than Suspend-to-memory,
>> known as S3.
>
> How does the application learn that its memory got wiped? S2disk is an
> async operation and it can happen at any time during the task =

> execution.
> So how does the application work to prevent from corrupted state - =

> e.g.
> when suspended between two memory loads?

The usual trick when using MADV_WIPEONFORK, or BSD=E2=80=99s MAP_INHERIT_=
ZERO, =

is to store a guard variable in the page and to check the variable any =

time that random data is generated.

Here=E2=80=99s an example of Google=E2=80=99s OpenSSL fork BoringSSL:

https://boringssl.googlesource.com/boringssl/+/ad5582985cc6b89d0e7caf0d9c=
c7e301de61cf66/crypto/fipsmodule/rand/fork_detect.c

Checking a guard variable for non-zero status will always happen =

atomically and monotonically (it won=E2=80=99t suddenly flip back) =E2=80=
=A6 which =

is all that=E2=80=99s needed in this case. If userspace applications need=
 to =

build a larger critical section around they can use regular concurrency =

controls, but it really doesn=E2=80=99t come up in this context. With =

WIPEONSUSPEND support in a kernel, I expect to add another madvise() =

call on the existing page. The manyworldsdetector micro-library is an =

example:


https://github.com/colmmacc/manyworldsdetector/blob/master/src/mwd.c

It=E2=80=99d be a new block in the style of lines 43-48.

-
Colm
