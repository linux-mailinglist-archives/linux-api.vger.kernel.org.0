Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DFFE225E
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbfJWSOf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 14:14:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388648AbfJWSOf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 14:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571854474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69szfWdpqzdUFsP2ofY5GztggRg6X4AKGP1hwjej5LU=;
        b=h5bp4Px+4HUuajOaynrZZIQFoJFzhApvDpIIx9hbR4zTfMrHnfHHG7DHUi8Y612M8l5oMi
        80Q1SyXPh3ujpv5ZslpL8NvR3sUpy1YwWaIdf0CXevH3g4DuQ9APgXuXp+6wR2bzx62HSb
        gltRC2azI/PtRBxSneoXdgxgfgyb0bo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-dI89Nn7BMRKXM8sofxgbkQ-1; Wed, 23 Oct 2019 14:14:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BC98801E5C;
        Wed, 23 Oct 2019 18:14:28 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 603B35D9DC;
        Wed, 23 Oct 2019 18:14:15 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm, vmstat: Release zone lock more frequently when
 reading /proc/pagetypeinfo
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
References: <20191023102737.32274-3-mhocko@kernel.org>
 <20191023173423.12532-1-longman@redhat.com>
 <20191023180121.GN17610@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <58a9adaf-9a1c-398b-dce1-cb30997807c1@redhat.com>
Date:   Wed, 23 Oct 2019 14:14:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191023180121.GN17610@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: dI89Nn7BMRKXM8sofxgbkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/23/19 2:01 PM, Michal Hocko wrote:
> On Wed 23-10-19 13:34:22, Waiman Long wrote:
>> With a threshold of 100000, it is still possible that the zone lock
>> will be held for a very long time in the worst case scenario where all
>> the counts are just below the threshold. With up to 6 migration types
>> and 11 orders, it means up to 6.6 millions.
>>
>> Track the total number of list iterations done since the acquisition
>> of the zone lock and release it whenever 100000 iterations or more have
>> been completed. This will cap the lock hold time to no more than 200,000
>> list iterations.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  mm/vmstat.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 57ba091e5460..c5b82fdf54af 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1373,6 +1373,7 @@ static void pagetypeinfo_showfree_print(struct seq=
_file *m,
>>  =09=09=09=09=09pg_data_t *pgdat, struct zone *zone)
>>  {
>>  =09int order, mtype;
>> +=09unsigned long iteration_count =3D 0;
>> =20
>>  =09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
>>  =09=09seq_printf(m, "Node %4d, zone %8s, type %12s ",
>> @@ -1397,15 +1398,24 @@ static void pagetypeinfo_showfree_print(struct s=
eq_file *m,
>>  =09=09=09=09 * of pages in this order should be more than
>>  =09=09=09=09 * sufficient
>>  =09=09=09=09 */
>> -=09=09=09=09if (++freecount >=3D 100000) {
>> +=09=09=09=09if (++freecount > 100000) {
>>  =09=09=09=09=09overflow =3D true;
>> -=09=09=09=09=09spin_unlock_irq(&zone->lock);
>> -=09=09=09=09=09cond_resched();
>> -=09=09=09=09=09spin_lock_irq(&zone->lock);
>> +=09=09=09=09=09freecount--;
>>  =09=09=09=09=09break;
>>  =09=09=09=09}
>>  =09=09=09}
>>  =09=09=09seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
>> +=09=09=09/*
>> +=09=09=09 * Take a break and release the zone lock when
>> +=09=09=09 * 100000 or more entries have been iterated.
>> +=09=09=09 */
>> +=09=09=09iteration_count +=3D freecount;
>> +=09=09=09if (iteration_count >=3D 100000) {
>> +=09=09=09=09iteration_count =3D 0;
>> +=09=09=09=09spin_unlock_irq(&zone->lock);
>> +=09=09=09=09cond_resched();
>> +=09=09=09=09spin_lock_irq(&zone->lock);
>> +=09=09=09}
> Aren't you overengineering this a bit? If you are still worried then we
> can simply cond_resched for each order
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index c156ce24a322..ddb89f4e0486 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1399,13 +1399,13 @@ static void pagetypeinfo_showfree_print(struct se=
q_file *m,
>  =09=09=09=09 */
>  =09=09=09=09if (++freecount >=3D 100000) {
>  =09=09=09=09=09overflow =3D true;
> -=09=09=09=09=09spin_unlock_irq(&zone->lock);
> -=09=09=09=09=09cond_resched();
> -=09=09=09=09=09spin_lock_irq(&zone->lock);
>  =09=09=09=09=09break;
>  =09=09=09=09}
>  =09=09=09}
>  =09=09=09seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
> +=09=09=09spin_unlock_irq(&zone->lock);
> +=09=09=09cond_resched();
> +=09=09=09spin_lock_irq(&zone->lock);
>  =09=09}
>  =09=09seq_putc(m, '\n');
>  =09}
>
> I do not have a strong opinion here but I can fold this into my patch 2.

If the free list is empty or is very short, there is probably no need to
release and reacquire the lock. How about adding a check for a lower
bound like:

if (freecount > 1000) {
=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&zone->lock);
=C2=A0=C2=A0=C2=A0 cond_resched();
=C2=A0=C2=A0=C2=A0 spin_lock_irq(&zone->lock);
}

Cheers,
Longman

