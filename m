Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17CE863D
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 12:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfJ2LCp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 07:02:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34623 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726562AbfJ2LCp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 07:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572346964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7sbbHmvNFaJzygr4NJBUlYrQ4azqMBo1OOsjTf8okk=;
        b=d/XsJyztV0/rs+6igdnuuZDfxcNimrykhwPdBMMHME0J/ntl07uHEdxbQIdPSxi5+ItZ7E
        EknoK+JRtDnj+5ubz/rD2b0vHecvM3bFotRh9b96+HdY9czHGI26g3MNZKYV5FF/NpS7Ud
        8HUwhnUm+qERPFWO0AYe3mlwa85BN4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-QvSRTwhiPeOIPJAKsYgcDw-1; Tue, 29 Oct 2019 07:02:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61D031800D67;
        Tue, 29 Oct 2019 11:02:38 +0000 (UTC)
Received: from [10.36.117.183] (ovpn-117-183.ams2.redhat.com [10.36.117.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D59DD600F4;
        Tue, 29 Oct 2019 11:02:34 +0000 (UTC)
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
To:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <085ed07e-e646-f7a4-0370-06f33a2a4e4a@redhat.com>
Date:   Tue, 29 Oct 2019 12:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1572171452-7958-2-git-send-email-rppt@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: QvSRTwhiPeOIPJAKsYgcDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 27.10.19 11:17, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>=20
> The mappings created with MAP_EXCLUSIVE are visible only in the context o=
f
> the owning process and can be used by applications to store secret
> information that will not be visible not only to other processes but to t=
he
> kernel as well.
>=20
> The pages in these mappings are removed from the kernel direct map and
> marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> the pages are mapped back into the direct map.
>=20

Just a thought, the kernel is still able to indirectly read the contents=20
of these pages by doing a kdump from kexec environment, right?. Also, I=20
wonder what would happen if you map such pages via /dev/mem into another=20
user space application and e.g., use them along with kvm [1].

[1] https://lwn.net/Articles/778240/

--=20

Thanks,

David / dhildenb

