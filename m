Return-Path: <linux-api+bounces-797-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469288470E7
	for <lists+linux-api@lfdr.de>; Fri,  2 Feb 2024 14:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA11C1F2A62D
	for <lists+linux-api@lfdr.de>; Fri,  2 Feb 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E292772A;
	Fri,  2 Feb 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zx7DQZie"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE194644E
	for <linux-api@vger.kernel.org>; Fri,  2 Feb 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879654; cv=none; b=mbsRCjpHptXgXcg/Rl8T34gJedjLECVabfY9azUqP8JkeWInWzEwKkPDf1tkW03C0inipffO4M8BCjmtkMeKz+zgqF9WtBw0AItgjI15coZLL3bms1ksxVCx0H+L8fS5hNo3hh8SpUf9HrKRTefrb3gsiQ5KEkYBk5pTlDD0SnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879654; c=relaxed/simple;
	bh=PhX+ubXI7FCPmRXptvhe+J5At0mfznoYNIfO29NGvGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b413xQpVt7IYm9bk/OcHiLhzW0z0xTt5QaHuFlWV9sXTxly20kJ4xK9c9T5fc45f2ZaRkWuHvuRZaGdjD13fYrx5NPaJ3KUlGfhDDkuRlp0qPKztH9xu82Fkn6l09UARqaqs3qWEq5M1KuWAU3LVYfhxeBVfJa9GfaEWFdVnHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zx7DQZie; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706879652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=9vsU4UH8CnAe6P5md1iwFJaffq8LntVkCJ8Quv5kMPs=;
	b=Zx7DQZieBN9R/yPLyOHtufqrmzQuIY+o7eut0WzRCUuybaGvJwKGDYnbSoebkxTm/JaSpb
	ujrf4eRRYF8ZGNEYvFKRo9KAGOMFijfrDsCItqu97Oer6MLmgTE3RTW9dh6i3UfhHMNQhu
	lofyyxG0YuV9p0gLIrwGV2mb2by35IQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-1J6EOV-NOzia-1h4KzNwNg-1; Fri,
 02 Feb 2024 08:14:10 -0500
X-MC-Unique: 1J6EOV-NOzia-1h4KzNwNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F95429AC00C;
	Fri,  2 Feb 2024 13:14:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id 936201121306;
	Fri,  2 Feb 2024 13:14:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Feb 2024 14:12:54 +0100 (CET)
Date: Fri, 2 Feb 2024 14:12:48 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pidfd: kill the no longer needed do_notify_pidfd() in
 de_thread()
Message-ID: <20240202131248.GA26022@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202131147.GA25988@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Now that __change_pid() does wake_up_all(&pid->wait_pidfd) we can kill
do_notify_pidfd(leader) in de_thread(), it calls release_task(leader)
right after that and this implies detach_pid(leader, PIDTYPE_PID).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/exec.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 0fd7e668c477..acd466f92998 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1143,11 +1143,6 @@ static int de_thread(struct task_struct *tsk)
 
 		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
 		leader->exit_state = EXIT_DEAD;
-		/*
-		 * leader and tsk exhanged their pids, the old pid dies,
-		 * wake up the PIDFD_THREAD waiters.
-		 */
-		do_notify_pidfd(leader);
 		/*
 		 * We are going to release_task()->ptrace_unlink() silently,
 		 * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
-- 
2.25.1.362.g51ebf55


