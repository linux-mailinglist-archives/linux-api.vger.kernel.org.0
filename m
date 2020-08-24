Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8306250134
	for <lists+linux-api@lfdr.de>; Mon, 24 Aug 2020 17:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgHXPdF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Aug 2020 11:33:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52174 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbgHXPax (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Aug 2020 11:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598283037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1YQ3gyXIJKMTUHtJJNp/oPK6RXcsK9K1cF1dewWatRk=;
        b=O49vB85yeIg9b5bbGACJ8ajxefNPqIKpYZwt4Z1qMKhhjMwHdwPeFRdE0w6KUrW3gcBOIa
        b5Br1EihW+vMHSePAvrH+C1TzuEY4l6J0l0DWgTsGaXNNoBmL3DYNG2+ICslSqyKmhHGNY
        hmk2dqfi/a3MIgPuod01U42DD7VgB18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-ld3EiieBMmq9cu9ub4Gd9A-1; Mon, 24 Aug 2020 11:30:35 -0400
X-MC-Unique: ld3EiieBMmq9cu9ub4Gd9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B130181CAFD;
        Mon, 24 Aug 2020 15:30:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D87C7038A;
        Mon, 24 Aug 2020 15:30:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] Add a manpage for watch_queue(7)
From:   David Howells <dhowells@redhat.com>
To:     mtk.manpages@gmail.com, me@benboeckel.net
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 16:30:31 +0100
Message-ID: <159828303137.330133.10953708050467314086.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a manual page for the notifications/watch_queue facility.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 man7/watch_queue.7 |  304 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 304 insertions(+)
 create mode 100644 man7/watch_queue.7

diff --git a/man7/watch_queue.7 b/man7/watch_queue.7
new file mode 100644
index 000000000..14c202cef
--- /dev/null
+++ b/man7/watch_queue.7
@@ -0,0 +1,304 @@
+.\"
+.\" Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+.\" Written by David Howells (dhowells@redhat.com)
+.\"
+.\" This program is free software; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public Licence
+.\" as published by the Free Software Foundation; either version
+.\" 2 of the Licence, or (at your option) any later version.
+.\"
+.TH WATCH_QUEUE 7 "2020-08-07" Linux "General Kernel Notifications"
+.SH NAME
+General kernel notification queue
+.SH SYNOPSIS
+#include <linux/watch_queue.h>
+.EX
+
+pipe2(fds, O_NOTIFICATION_PIPE);
+ioctl(fds[0], IOC_WATCH_QUEUE_SET_SIZE, max_message_count);
+ioctl(fds[0], IOC_WATCH_QUEUE_SET_FILTER, &filter);
+keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fds[0], message_tag);
+for (;;) {
+	buf_len = read(fds[0], buffer, sizeof(buffer));
+	...
+}
+.EE
+.SH OVERVIEW
+.PP
+The general kernel notification queue is a general purpose transport for kernel
+notification messages to userspace.  Notification messages are marked with type
+information so that events from multiple sources can be distinguished.
+Messages are also of variable length to accommodate different information for
+each type.
+.PP
+Queues are implemented on top of standard pipes and multiple independent queues
+can be created.  After a pipe has been created, its size and filtering can be
+configured and event sources attached.  The pipe can then be read or polled to
+wait for messages.
+.PP
+Multiple messages may be read out of the queue at a time if the buffer is large
+enough, but messages will not get split amongst multiple reads.  If the buffer
+isn't large enough for a message,
+.B ENOBUFS
+will be returned.
+.PP
+In the case of message loss,
+.BR read (2)
+will fabricate a loss message and pass that to userspace immediately after the
+point at which the loss occurred.  A single loss message is generated, even if
+multiple messages get lost at the same point.
+.PP
+A notification pipe allocates a certain amount of locked kernel memory (so that
+the kernel can write a notification into it from contexts where allocation is
+restricted), and so is subject to pipe resource limit restrictions - see
+.BR pipe (7),
+in the section on
+.BR "/proc files" .
+.PP
+Sources must be attached to a queue manually; there's no single global event
+source, but rather a variety of sources, each of which can be attached to by
+multiple queues.  Attachments can be set up by:
+.TP
+.BR keyctl_watch_key (3)
+Monitor a key or keyring for changes.
+.PP
+Because a source can produce a lot of different events, not all of which may
+be of interest to the watcher, a single set of filters can be set on a queue
+to determine whether a particular event will get inserted in a queue at the
+point of posting inside the kernel.
+.SH MESSAGE STRUCTURE
+.PP
+The output from reading the pipe is divided into variable length messages.
+.BR read (2)
+will never split a message across two separate read calls.  Each message
+begins with a header of the form:
+.PP
+.in +4n
+.EX
+struct watch_notification {
+	__u32	type:24;
+	__u32	subtype:8;
+	__u32	info;
+};
+.EE
+.in
+.PP
+Where
+.I type
+indicates the general class of notification,
+.I subtype
+indicates the specific type of notification within that class and
+.I info
+includes the message length (in bytes), the watcher's ID and some type-specific
+information.
+.PP
+A special message type,
+.BR WATCH_TYPE_META ,
+exists to convey information about the notification facility itself.  It has
+the following subtypes:
+.TP
+.B WATCH_META_LOSS_NOTIFICATION
+This indicates one or more messages were lost, probably due to a buffer
+overrun.
+.TP
+.B WATCH_META_REMOVAL_NOTIFICATION
+This indicates that a notification source went away whilst it is being watched.
+This comes in two lengths: a short variant that carries just the header and a
+long variant that includes a 64-bit identifier as well that identifies the
+source more precisely (which variant is used and how the identifier should be
+interpreted is source dependent).
+.PP
+.I info
+includes the following fields:
+.TP
+.B WATCH_INFO_LENGTH
+Bits 0-6 indicate the size of the message in bytes, and can be between 8 and
+127.
+.TP
+.B WATCH_INFO_ID
+Bits 8-15 indicate the tag given to the source binding call.  This is a number
+between 0 and 255 and is purely a source index for userspace's use and isn't
+interpreted by the kernel.
+.TP
+.B WATCH_INFO_TYPE_INFO
+Bits 16-31 indicate subtype-dependent information.
+.SH IOCTL COMMANDS
+Pipes opened with
+.B O_NOTIFICATION_PIPE
+have the following
+.BR ioctl (2)
+commands available:
+.TP
+.B IOC_WATCH_QUEUE_SET_SIZE
+The ioctl argument is indicates the maximum number of messages that can be
+inserted into the pipe.  This must be a power of two.  This command also
+pre-allocates memory to hold messages.
+.IP
+This may only be done once and the queue cannot be used until this command has
+been done.
+.TP
+.B IOC_WATCH_QUEUE_SET_FILTER
+This is used to set filters on the notifications that get written into the
+buffer.  See the section on filtering for details.
+.SH FILTERING
+.PP
+The
+.B IOC_WATH_QUEUE_SET_FILTER
+ioctl argument points to a structure of the following form:
+.PP
+.in +4n
+.EX
+struct watch_notification_filter {
+	__u32	nr_filters;
+	__u32	__reserved;
+	struct watch_notification_type_filter filters[];
+};
+.EE
+.in
+.PP
+Where
+.I nr_filters
+indicates the number of elements in the
+.IR filters []
+array, and
+.I __reserved
+should be 0.  Each element in the filters array specifies a filter and is of
+the following form:
+.PP
+.in +4n
+.EX
+struct watch_notification_type_filter {
+	__u32	type;
+	__u32	info_filter;
+	__u32	info_mask;
+	__u32	subtype_filter[8];
+};
+.EE
+.in
+.PP
+Where
+.I type
+refers to the type field in a notification record header;
+.IR info_filter " and " info_mask
+refer to the info field; and
+.I subtype_filter
+is a bit-mask of permitted subtypes.
+.PP
+A notification matches a filter if all of the following are true:
+.in +4n
+.PP
+(*) The type on the notification matches that on the filter.
+.PP
+(*) The bit in subtype_filter that matches the notification subtype is set.
+Each element in subtype_filter[] covers 32 subtypes, with, for example,
+element 0 matching subtypes 0-31.  This can be summarised as:
+.PP
+.in +4n
+.EX
+F->subtype_filter[N->subtype / 32] & (1U << (N->subtype % 32))
+.EE
+.in
+.PP
+(*) The notification info, masked off, matches the filter info, e.g.:
+.PP
+.in +4n
+.EX
+(N->info & F->info_mask) == F->info_filter
+.EE
+.in
+.PP
+If no filters are set, all notifications are allowed by default and if one or
+more filters are set, notifications are disallowed by default.
+WATCH_TYPE_META cannot, however, be filtered.
+.SH VERSIONS
+The notification queue driver first appeared in v5.8 of the Linux kernel.
+.SH EXAMPLE
+To use the notification mechanism, first of all the pipe has to be opened and
+the size must be set:
+.PP
+.in +4n
+.EX
+int fds[2];
+pipe2(fd[0], O_NOTIFICATION_QUEUE);
+int wfd = fd[0];
+
+ioctl(wfd, IOC_WATCH_QUEUE_SET_SIZE, 16);
+.EE
+.in
+.PP
+From this point, the queue is open for business.  Filters can be set to
+restrict the notifications that get inserted into the queue from the sources
+that are being watched.  For example:
+.PP
+.in +4n
+.EX
+static struct watch_notification_filter filter = {
+	.nr_filters	= 1,
+	.__reserved	= 0,
+	.filters = {
+		[0]	= {
+			.type			= WATCH_TYPE_KEY_NOTIFY,
+			.subtype_filter[0]	= 1 << NOTIFY_KEY_LINKED,
+			.info_filter		= 1 << WATCH_INFO_FLAG_2,
+			.info_mask		= 1 << WATCH_INFO_FLAG_2,
+		},
+	},
+};
+
+ioctl(wfd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
+.EE
+.in
+.PP
+will only allow key-change notifications that indicate a key is linked into a
+keyring and then only if type-specific flag WATCH_INFO_FLAG_2 is set on the
+notification.
+.PP
+Sources can then be watched, for example:
+.PP
+.in +4n
+.EX
+keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, wfd, 0x33);
+.EE
+.in
+.PP
+The first places a watch on the process's session keyring, directing the
+notifications to the buffer we just created and specifying that they should be
+tagged with 0x33 in the info ID field.
+.PP
+When it is determined that there is something in the buffer, messages can be
+read out of the ring with something like the following:
+.PP
+.in +4n
+.EX
+for (;;) {
+	unsigned char buf[WATCH_INFO_LENGTH];
+	read(fd, buf, sizeof(buf));
+	struct watch_notification *n = (struct watch_notification *)buf;
+	switch (n->type) {
+	case WATCH_TYPE_META:
+		switch (n->subtype) {
+		case WATCH_META_REMOVAL_NOTIFICATION:
+			saw_removal_notification(n);
+			break;
+		case WATCH_META_LOSS_NOTIFICATION:
+			printf("-- LOSS --\n");
+			break;
+		}
+		break;
+	case WATCH_TYPE_KEY_NOTIFY:
+		saw_key_change(n);
+		break;
+	}
+}
+.EE
+.in
+.PP
+
+.SH SEE ALSO
+.ad l
+.nh
+.BR keyctl (1),
+.BR ioctl (2),
+.BR pipe2 (2),
+.BR read (2),
+.BR keyctl_watch_key (3)


