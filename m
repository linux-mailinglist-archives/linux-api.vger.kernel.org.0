Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606BCE21E7
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJWRff (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 13:35:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34546 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730783AbfJWRfb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 13:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571852130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYPluV593635tS2En896gI8nsdrbZHAmMeMjWWNFoNQ=;
        b=bqHj+xvPlJ3pHHEVJTKupVCycdfvW4gSoedVTdQDpkhgN2vHhQhTEpYNWDgUvfsOp+QWEX
        +LRE7yuMThSaxmo9c8M1tvS9eW3QKus1z73bxqxUKQd/8lmiy4Iau0v5GSP9RVEI5xCHWA
        awHGrR2CCqZW1YLN5IjVgtig4BI0HtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-86yMyZUaPui-i3hDilpdVA-1; Wed, 23 Oct 2019 13:35:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 645CA107AD34;
        Wed, 23 Oct 2019 17:35:24 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CABF5D6D0;
        Wed, 23 Oct 2019 17:35:22 +0000 (UTC)
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
Subject: [PATCH 2/2] mm, vmstat: List total free blocks for each order in /proc/pagetypeinfo
Date:   Wed, 23 Oct 2019 13:34:23 -0400
Message-Id: <20191023173423.12532-2-longman@redhat.com>
In-Reply-To: <20191023102737.32274-3-mhocko@kernel.org>
References: <20191023102737.32274-3-mhocko@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 86yMyZUaPui-i3hDilpdVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Now that the free block count for each migration types in
/proc/pagetypeinfo may not show the exact count if it excceeds
100,000. Users may not know how much more the counts will be. As the
free_area structure has already tracked the total free block count in
nr_free, we may as well print it out with no additional cost. That will
give users a rough idea of where the upper bounds will be.

If there is no overflow, the presence of the total counts will also
enable us to check if the nr_free counts match the total number of
entries in the free lists.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/vmstat.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index c5b82fdf54af..172946d8f358 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1373,6 +1373,7 @@ static void pagetypeinfo_showfree_print(struct seq_fi=
le *m,
 =09=09=09=09=09pg_data_t *pgdat, struct zone *zone)
 {
 =09int order, mtype;
+=09struct free_area *area;
 =09unsigned long iteration_count =3D 0;
=20
 =09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
@@ -1382,7 +1383,6 @@ static void pagetypeinfo_showfree_print(struct seq_fi=
le *m,
 =09=09=09=09=09migratetype_names[mtype]);
 =09=09for (order =3D 0; order < MAX_ORDER; ++order) {
 =09=09=09unsigned long freecount =3D 0;
-=09=09=09struct free_area *area;
 =09=09=09struct list_head *curr;
 =09=09=09bool overflow =3D false;
=20
@@ -1419,6 +1419,17 @@ static void pagetypeinfo_showfree_print(struct seq_f=
ile *m,
 =09=09}
 =09=09seq_putc(m, '\n');
 =09}
+
+=09/*
+=09 * List total free blocks per order
+=09 */
+=09seq_printf(m, "Node %4d, zone %8s, total             ",
+=09=09   pgdat->node_id, zone->name);
+=09for (order =3D 0; order < MAX_ORDER; ++order) {
+=09=09area =3D &(zone->free_area[order]);
+=09=09seq_printf(m, "%6lu ", area->nr_free);
+=09}
+=09seq_putc(m, '\n');
 }
=20
 /* Print out the free pages at each order for each migatetype */
--=20
2.18.1

