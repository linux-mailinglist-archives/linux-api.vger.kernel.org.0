Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0AF8507
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 01:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLATT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 19:19:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23287 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726981AbfKLATR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 19:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573517956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4Qp+qAWnA86YTq8ORascu57Z8nk2SYkcadQHnIe57pg=;
        b=FNeNjNQopOwh6qMaoB5qkzjRCnAsZzEyZvVGkm5o6jl6fhccHrqv1ngsPD/yZzcqAiO/3C
        OVYZOlcyEVW+C0Oxsi/gab8arz/5uExOCsfkD8KLK/e4i8ZZ0GZbUOT2PRbdt+RbeqpNUY
        aaB7wVpAF0o4mDDzsRQpypdj4RZJN6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-3uhtm5eUN8qa7yP-FZ0psw-1; Mon, 11 Nov 2019 19:19:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30225800C72;
        Tue, 12 Nov 2019 00:19:03 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-123-234.rdu2.redhat.com [10.10.123.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4351210027B6;
        Tue, 12 Nov 2019 00:19:01 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     linux-api@vger.kernel.org, idryomov@gmail.com, mhocko@kernel.org,
        david@fromorbit.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        martin@urbackup.org, Damien.LeMoal@wdc.com
Cc:     Mike Christie <mchristi@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] Add prctl support for controlling mem reclaim V4
Date:   Mon, 11 Nov 2019 18:19:00 -0600
Message-Id: <20191112001900.9206-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3uhtm5eUN8qa7yP-FZ0psw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
amd nbd that have userspace components that can run in the IO path. For
example, iscsi and nbd's userspace deamons may need to recreate a socket
and/or send IO on it, and dm-multipath's daemon multipathd may need to
send SG IO or read/write IO to figure out the state of paths and re-set
them up.

In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
memalloc_*_save/restore functions to control the allocation behavior,
but for userspace we would end up hitting an allocation that ended up
writing data back to the same device we are trying to allocate for.
The device is then in a state of deadlock, because to execute IO the
device needs to allocate memory, but to allocate memory the memory
layers want execute IO to the device.

Here is an example with nbd using a local userspace daemon that performs
network IO to a remote server. We are using XFS on top of the nbd device,
but it can happen with any FS or other modules layered on top of the nbd
device that can write out data to free memory.  Here a nbd daemon helper
thread, msgr-worker-1, is performing a write/sendmsg on a socket to execute
a request. This kicks off a reclaim operation which results in a WRITE to
the nbd device and the nbd thread calling back into the mm layer.

[ 1626.609191] msgr-worker-1   D    0  1026      1 0x00004000
[ 1626.609193] Call Trace:
[ 1626.609195]  ? __schedule+0x29b/0x630
[ 1626.609197]  ? wait_for_completion+0xe0/0x170
[ 1626.609198]  schedule+0x30/0xb0
[ 1626.609200]  schedule_timeout+0x1f6/0x2f0
[ 1626.609202]  ? blk_finish_plug+0x21/0x2e
[ 1626.609204]  ? _xfs_buf_ioapply+0x2e6/0x410
[ 1626.609206]  ? wait_for_completion+0xe0/0x170
[ 1626.609208]  wait_for_completion+0x108/0x170
[ 1626.609210]  ? wake_up_q+0x70/0x70
[ 1626.609212]  ? __xfs_buf_submit+0x12e/0x250
[ 1626.609214]  ? xfs_bwrite+0x25/0x60
[ 1626.609215]  xfs_buf_iowait+0x22/0xf0
[ 1626.609218]  __xfs_buf_submit+0x12e/0x250
[ 1626.609220]  xfs_bwrite+0x25/0x60
[ 1626.609222]  xfs_reclaim_inode+0x2e8/0x310
[ 1626.609224]  xfs_reclaim_inodes_ag+0x1b6/0x300
[ 1626.609227]  xfs_reclaim_inodes_nr+0x31/0x40
[ 1626.609228]  super_cache_scan+0x152/0x1a0
[ 1626.609231]  do_shrink_slab+0x12c/0x2d0
[ 1626.609233]  shrink_slab+0x9c/0x2a0
[ 1626.609235]  shrink_node+0xd7/0x470
[ 1626.609237]  do_try_to_free_pages+0xbf/0x380
[ 1626.609240]  try_to_free_pages+0xd9/0x1f0
[ 1626.609245]  __alloc_pages_slowpath+0x3a4/0xd30
[ 1626.609251]  ? ___slab_alloc+0x238/0x560
[ 1626.609254]  __alloc_pages_nodemask+0x30c/0x350
[ 1626.609259]  skb_page_frag_refill+0x97/0xd0
[ 1626.609274]  sk_page_frag_refill+0x1d/0x80
[ 1626.609279]  tcp_sendmsg_locked+0x2bb/0xdd0
[ 1626.609304]  tcp_sendmsg+0x27/0x40
[ 1626.609307]  sock_sendmsg+0x54/0x60
[ 1626.609308]  ___sys_sendmsg+0x29f/0x320
[ 1626.609313]  ? sock_poll+0x66/0xb0
[ 1626.609318]  ? ep_item_poll.isra.15+0x40/0xc0
[ 1626.609320]  ? ep_send_events_proc+0xe6/0x230
[ 1626.609322]  ? hrtimer_try_to_cancel+0x54/0xf0
[ 1626.609324]  ? ep_read_events_proc+0xc0/0xc0
[ 1626.609326]  ? _raw_write_unlock_irq+0xa/0x20
[ 1626.609327]  ? ep_scan_ready_list.constprop.19+0x218/0x230
[ 1626.609329]  ? __hrtimer_init+0xb0/0xb0
[ 1626.609331]  ? _raw_spin_unlock_irq+0xa/0x20
[ 1626.609334]  ? ep_poll+0x26c/0x4a0
[ 1626.609337]  ? tcp_tsq_write.part.54+0xa0/0xa0
[ 1626.609339]  ? release_sock+0x43/0x90
[ 1626.609341]  ? _raw_spin_unlock_bh+0xa/0x20
[ 1626.609342]  __sys_sendmsg+0x47/0x80
[ 1626.609347]  do_syscall_64+0x5f/0x1c0
[ 1626.609349]  ? prepare_exit_to_usermode+0x75/0xa0
[ 1626.609351]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

This patch adds a new prctl command that daemons can use after they have
done their initial setup, and before they start to do allocations that
are in the IO path. It sets the PF_MEMALLOC_NOIO and PF_LESS_THROTTLE
flags so both userspace block and FS threads can use it to avoid the
allocation recursion and try to prevent from being throttled while
writing out data to free up memory.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Tested-by: Masato Suzuki <masato.suzuki@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

---

V4:
- Fix PR_GET_IO_FLUSHER check to match SET.

V3:
- Drop NOFS, set PF_LESS_THROTTLE and rename prctl flag to reflect it
is more general and can support both FS and block devices. Both fuse
and block device daemons, nbd and tcmu-runner, have been tested to
confirm the more restrictive PF_MEMALLOC_NOIO also works for fuse.

- Use CAP_SYS_RESOURCE instead of admin.

V2:
- Use prctl instead of procfs.
- Add support for NOFS for fuse.
- Check permissions.


 include/uapi/linux/capability.h |  1 +
 include/uapi/linux/prctl.h      |  4 ++++
 kernel/sys.c                    | 25 +++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capabilit=
y.h
index 240fdb9a60f6..272dc69fa080 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -301,6 +301,7 @@ struct vfs_ns_cap_data {
 /* Allow more than 64hz interrupts from the real-time clock */
 /* Override max number of consoles on console allocation */
 /* Override max number of keymaps */
+/* Control memory reclaim behavior */
=20
 #define CAP_SYS_RESOURCE     24
=20
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 7da1b37b27aa..07b4f8131e36 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -234,4 +234,8 @@ struct prctl_mm_map {
 #define PR_GET_TAGGED_ADDR_CTRL=09=0956
 # define PR_TAGGED_ADDR_ENABLE=09=09(1UL << 0)
=20
+/* Control reclaim behavior when allocating memory */
+#define PR_SET_IO_FLUSHER=09=0957
+#define PR_GET_IO_FLUSHER=09=0958
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index a611d1d58c7d..c1a360370d09 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2259,6 +2259,8 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struc=
t *t, unsigned long which,
 =09return -EINVAL;
 }
=20
+#define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LESS_THROTTLE)
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, ar=
g3,
 =09=09unsigned long, arg4, unsigned long, arg5)
 {
@@ -2486,6 +2488,29 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, a=
rg2, unsigned long, arg3,
 =09=09=09return -EINVAL;
 =09=09error =3D GET_TAGGED_ADDR_CTRL();
 =09=09break;
+=09case PR_SET_IO_FLUSHER:
+=09=09if (!capable(CAP_SYS_RESOURCE))
+=09=09=09return -EPERM;
+
+=09=09if (arg3 || arg4 || arg5)
+=09=09=09return -EINVAL;
+
+=09=09if (arg2 =3D=3D 1)
+=09=09=09current->flags |=3D PR_IO_FLUSHER;
+=09=09else if (!arg2)
+=09=09=09current->flags &=3D ~PR_IO_FLUSHER;
+=09=09else
+=09=09=09return -EINVAL;
+=09=09break;
+=09case PR_GET_IO_FLUSHER:
+=09=09if (!capable(CAP_SYS_RESOURCE))
+=09=09=09return -EPERM;
+
+=09=09if (arg2 || arg3 || arg4 || arg5)
+=09=09=09return -EINVAL;
+
+=09=09error =3D (current->flags & PR_IO_FLUSHER) =3D=3D PR_IO_FLUSHER;
+=09=09break;
 =09default:
 =09=09error =3D -EINVAL;
 =09=09break;
--=20
2.20.1

