Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8374FE21E5
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 19:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfJWRf3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 13:35:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730701AbfJWRf2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 13:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571852127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oah+sFD9h93XFRkeqX7YtNgEo2DG0iEGX0WBNwPsTlM=;
        b=Nop5ShQ+FgnDnq0aDnpm6bO805h6T4631T55rQDDBB1plr0CrHaZ0+oA36pYBA+6CDdIZb
        Ihoz9Yx5mvov2bca0A/e914kZbYlGjTE0jwlwJOKKMWAIe92QCrcnqdTlxZjeL843Ekmko
        a5xyqzX4IDl8RowtApBnvskFHHE7mww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-eJR6LbkuMiWkvuEX-NSWCw-1; Wed, 23 Oct 2019 13:35:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 669081800E01;
        Wed, 23 Oct 2019 17:35:22 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A3E45D6D0;
        Wed, 23 Oct 2019 17:35:13 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] mm, vmstat: Release zone lock more frequently when reading /proc/pagetypeinfo
Date:   Wed, 23 Oct 2019 13:34:22 -0400
Message-Id: <20191023173423.12532-1-longman@redhat.com>
In-Reply-To: <20191023102737.32274-3-mhocko@kernel.org>
References: <20191023102737.32274-3-mhocko@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: eJR6LbkuMiWkvuEX-NSWCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

With a threshold of 100000, it is still possible that the zone lock
will be held for a very long time in the worst case scenario where all
the counts are just below the threshold. With up to 6 migration types
and 11 orders, it means up to 6.6 millions.

Track the total number of list iterations done since the acquisition
of the zone lock and release it whenever 100000 iterations or more have
been completed. This will cap the lock hold time to no more than 200,000
list iterations.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/vmstat.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 57ba091e5460..c5b82fdf54af 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1373,6 +1373,7 @@ static void pagetypeinfo_showfree_print(struct seq_fi=
le *m,
 =09=09=09=09=09pg_data_t *pgdat, struct zone *zone)
 {
 =09int order, mtype;
+=09unsigned long iteration_count =3D 0;
=20
 =09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
 =09=09seq_printf(m, "Node %4d, zone %8s, type %12s ",
@@ -1397,15 +1398,24 @@ static void pagetypeinfo_showfree_print(struct seq_=
file *m,
 =09=09=09=09 * of pages in this order should be more than
 =09=09=09=09 * sufficient
 =09=09=09=09 */
-=09=09=09=09if (++freecount >=3D 100000) {
+=09=09=09=09if (++freecount > 100000) {
 =09=09=09=09=09overflow =3D true;
-=09=09=09=09=09spin_unlock_irq(&zone->lock);
-=09=09=09=09=09cond_resched();
-=09=09=09=09=09spin_lock_irq(&zone->lock);
+=09=09=09=09=09freecount--;
 =09=09=09=09=09break;
 =09=09=09=09}
 =09=09=09}
 =09=09=09seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
+=09=09=09/*
+=09=09=09 * Take a break and release the zone lock when
+=09=09=09 * 100000 or more entries have been iterated.
+=09=09=09 */
+=09=09=09iteration_count +=3D freecount;
+=09=09=09if (iteration_count >=3D 100000) {
+=09=09=09=09iteration_count =3D 0;
+=09=09=09=09spin_unlock_irq(&zone->lock);
+=09=09=09=09cond_resched();
+=09=09=09=09spin_lock_irq(&zone->lock);
+=09=09=09}
 =09=09}
 =09=09seq_putc(m, '\n');
 =09}
--=20
2.18.1

