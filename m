Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F208162B80
	for <lists+linux-api@lfdr.de>; Tue, 18 Feb 2020 18:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBRRHT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 12:07:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58417 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgBRRHS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 12:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yz1PYlAw+vwqrPPhOUgTLgnA2ip0cR1UD//JiPCA6VE=;
        b=Cf5XhqAyAKryQWPTCKBJh9zflFwEoLvRgTerMjpHXO/vhHQgKa0GuPiNTLwljnKt7fZmGf
        8O+yjPpHzvcGtXFw0udHIYHygW9fRUye7GrPfrCblB+ZtyoyrrtuWKHq1aVLk3I/QyuE7i
        rPbb4FPCVMR0IWCy9z05Xuu3n6gjKSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-0aXLmRmnPv6grXEqVq-w4Q-1; Tue, 18 Feb 2020 12:06:47 -0500
X-MC-Unique: 0aXLmRmnPv6grXEqVq-w4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00C6F800D54;
        Tue, 18 Feb 2020 17:06:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BFD260BE1;
        Tue, 18 Feb 2020 17:06:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/19] notifications: sample: Display mount tree change
 notifications [ver #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:06:43 +0000
Message-ID: <158204560384.3299825.6958748686538640876.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is run like:

	./watch_test

and watches "/" for changes to the mount topology and the attributes of
individual mount objects.

	# mount -t tmpfs none /mnt
	# mount -o remount,ro /mnt
	# mount -o remount,rw /mnt

producing:

	# ./watch_test
	read() = 16
	NOTIFY[000]: ty=000002 sy=00 i=02000010
	MOUNT 00000060 change=0[new_mount] aux=416
	read() = 16
	NOTIFY[000]: ty=000002 sy=04 i=02010010
	MOUNT 000001a0 change=4[setattr] aux=0
	read() = 16
	NOTIFY[000]: ty=000002 sy=04 i=02010010
	MOUNT 000001a0 change=4[setattr] aux=0

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/watch_queue/watch_test.c |   39 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 0eaff5dc04c3..49d185150506 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -26,6 +26,9 @@
 #ifndef __NR_watch_devices
 #define __NR_watch_devices -1
 #endif
+#ifndef __NR_watch_mount
+#define __NR_watch_mount -1
+#endif
 
 #define BUF_SIZE 256
 
@@ -58,6 +61,27 @@ static void saw_key_change(struct watch_notification *n, size_t len)
 	       k->key_id, n->subtype, key_subtypes[n->subtype], k->aux);
 }
 
+static const char *mount_subtypes[256] = {
+	[NOTIFY_MOUNT_NEW_MOUNT]	= "new_mount",
+	[NOTIFY_MOUNT_UNMOUNT]		= "unmount",
+	[NOTIFY_MOUNT_EXPIRY]		= "expiry",
+	[NOTIFY_MOUNT_READONLY]		= "readonly",
+	[NOTIFY_MOUNT_SETATTR]		= "setattr",
+	[NOTIFY_MOUNT_MOVE_FROM]	= "move_from",
+	[NOTIFY_MOUNT_MOVE_TO]		= "move_to",
+};
+
+static void saw_mount_change(struct watch_notification *n, size_t len)
+{
+	struct mount_notification *m = (struct mount_notification *)n;
+
+	if (len != sizeof(struct mount_notification))
+		return;
+
+	printf("MOUNT %08x change=%u[%s] aux=%u\n",
+	       m->triggered_on, n->subtype, mount_subtypes[n->subtype], m->changed_mount);
+}
+
 /*
  * Consume and display events.
  */
@@ -134,6 +158,9 @@ static void consumer(int fd)
 			default:
 				printf("other type\n");
 				break;
+			case WATCH_TYPE_MOUNT_NOTIFY:
+				saw_mount_change(&n.n, len);
+				break;
 			}
 
 			p += len;
@@ -142,12 +169,17 @@ static void consumer(int fd)
 }
 
 static struct watch_notification_filter filter = {
-	.nr_filters	= 1,
+	.nr_filters	= 2,
 	.filters = {
 		[0]	= {
 			.type			= WATCH_TYPE_KEY_NOTIFY,
 			.subtype_filter[0]	= UINT_MAX,
 		},
+		[1] = {
+			.type			= WATCH_TYPE_MOUNT_NOTIFY,
+			// Reject move-from notifications
+			.subtype_filter[0]	= UINT_MAX & ~(1 << NOTIFY_MOUNT_MOVE_FROM),
+		},
 	},
 };
 
@@ -181,6 +213,11 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (syscall(__NR_watch_mount, AT_FDCWD, "/", 0, fd, 0x02) == -1) {
+		perror("watch_mount");
+		exit(1);
+	}
+
 	consumer(fd);
 	exit(0);
 }


