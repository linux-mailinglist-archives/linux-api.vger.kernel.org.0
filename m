Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C65E97FC
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 09:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfJ3ITp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 04:19:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57786 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726246AbfJ3ITp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Oct 2019 04:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572423584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGP8/Cq/uIP6+eazYurLTr329KXGMw2YjLoiUkgJNCw=;
        b=JSDcl6LZWYcSgXZeDubSupTVoEvXEQKl1OeK/yVq7WCNXPM1l0G/YIGkBFClkmEiFQkjUn
        1tuoElZkQKbZBvrIZRdHRvmUIFRz8onSPWkF8b18k+8YcaXI3n1E3kzLh/JLFRSjWW9CuF
        vxd2N9MIayLJLv7WsMptI0LRmajLisE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-CSJ1tpiVO8yEP9kAKb589Q-1; Wed, 30 Oct 2019 04:19:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F500107AD28;
        Wed, 30 Oct 2019 08:19:38 +0000 (UTC)
Received: from [10.36.116.222] (ovpn-116-222.ams2.redhat.com [10.36.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91E5D60C4B;
        Wed, 30 Oct 2019 08:19:34 +0000 (UTC)
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <085ed07e-e646-f7a4-0370-06f33a2a4e4a@redhat.com>
 <20191030081529.GB20624@rapoport-lnx>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9eae3941-64cf-4ea1-0287-0e64bab192c6@redhat.com>
Date:   Wed, 30 Oct 2019 09:19:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191030081529.GB20624@rapoport-lnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: CSJ1tpiVO8yEP9kAKb589Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 30.10.19 09:15, Mike Rapoport wrote:
> On Tue, Oct 29, 2019 at 12:02:34PM +0100, David Hildenbrand wrote:
>> On 27.10.19 11:17, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> The mappings created with MAP_EXCLUSIVE are visible only in the context=
 of
>>> the owning process and can be used by applications to store secret
>>> information that will not be visible not only to other processes but to=
 the
>>> kernel as well.
>>>
>>> The pages in these mappings are removed from the kernel direct map and
>>> marked with PG_user_exclusive flag. When the exclusive area is unmapped=
,
>>> the pages are mapped back into the direct map.
>>>
>>
>> Just a thought, the kernel is still able to indirectly read the contents=
 of
>> these pages by doing a kdump from kexec environment, right?
>=20
> Right.
>=20
>> Also, I wonder
>> what would happen if you map such pages via /dev/mem into another user s=
pace
>> application and e.g., use them along with kvm [1].
>=20
> Do you mean that one application creates MAP_EXCLUSIVE and another
> applications accesses the same physical pages via /dev/mem?

Exactly.

>=20
> With /dev/mem all physical memory is visible...

Okay, so the statement "information that will not be visible not only to=20
other processes but to the kernel as well" is not correct. There are=20
easy ways to access that information if you really want to (might=20
require root permissions, though).

--=20

Thanks,

David / dhildenb

