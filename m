Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E0C19D67D
	for <lists+linux-api@lfdr.de>; Fri,  3 Apr 2020 14:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403876AbgDCMLp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Apr 2020 08:11:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33086 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403859AbgDCMLp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Apr 2020 08:11:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so8296118wrd.0;
        Fri, 03 Apr 2020 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WQVTbDEDjFr4O1/Say+4s7vNmlllW/RrwEUKTO3oWa8=;
        b=TP8Lye1ieaOT12W1mNC+gBP2C8/zdudJ0dgxpWpHbJ+mSWs/WMlXAkoGe6kEuwKcDS
         Fy/qipHyfOTYH3XapK5yjVHr70F8Ap/IRCP0fwL4CKXAJwJ2UzHgQfqDoCkjfWhfFCmD
         16JZhKhnDLhGTARKcDD709jkRT6w1KU4tkaamJU6bOyCmgzokDusLz+rfLbQwI72iz7p
         G/dXOfBBiLVZTjyj2dy/jP1B+FVbzkWc15JozPNkODqWwCJu8idVk6qa/7/nwbCP385p
         ba60yIRL8xi8HuYjMAVCjTySbinwg1or59ixFBUR9XveaMOOUFoEzB56O+72Caoph5fI
         Mi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WQVTbDEDjFr4O1/Say+4s7vNmlllW/RrwEUKTO3oWa8=;
        b=eTdB4lsPrlJdRf29s3lJZqjktTgJt1hJTbkQRSMe0cQ/iF3ADMCLfsiwF4dVgSbCkF
         DL0nixz7p5jKQfTrJQ/CT/RJJMhEjEcoDeAIJpWcOVFgtowrDSq9+tEl49X1DJ4otcJ7
         WglKh9txz3QCFhGNDksU9WDO7vWzBjeoc0D6/lSvyB0lWSDDIXU2p2Ib33sLND4elGXe
         Eqq1p3Y3Iyli6heHR95WO7SDbgaqnDXjkfoDri+JbBQsB0O1oj6MMF9LkO0zxo6LgzM4
         +VMpcCGACc+hF6Ae943hyMJbYcJfch+cW8/e/1uPF+ktInWwEIR0Ix7R3MuqE2Tp7tr/
         jaXw==
X-Gm-Message-State: AGi0PuZpNN1fcmubg3Btx7w37J8K5vQWK/h4zD+LH0szsLl72WCYzyZY
        kJmWut5KYHneGNk1XMS4PHOkFJhz
X-Google-Smtp-Source: APiQypKf7jEOtuElOnZb8aETb4jmcZ9jf8R5ft545q5pRetS8T3tqZmdVX6gJiFykqA8bMjea7SAsw==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr8937558wru.317.1585915903067;
        Fri, 03 Apr 2020 05:11:43 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id v186sm11229090wme.24.2020.04.03.05.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 05:11:41 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Adrian Reber <adrian@lisas.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Containers <containers@lists.linux-foundation.org>
To:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.or>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH] ns: Fix time_for_children symlink
Message-ID: <a2418c48-ed80-3afe-116e-6611cb799557@gmail.com>
Date:   Fri, 3 Apr 2020 14:11:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dmitry, Andrei,

Looking at the contents of the /proc/PID/ns/time_for_children
symlink shows an anomaly:

$ ls -l /proc/self/ns/* |awk '{print $9, $10, $11}'
...
/proc/self/ns/pid -> pid:[4026531836]
/proc/self/ns/pid_for_children -> pid:[4026531836]
/proc/self/ns/time -> time:[4026531834]
/proc/self/ns/time_for_children -> time_for_children:[4026531834]
/proc/self/ns/user -> user:[4026531837]
...

The reference for 'time_for_children' should be a 'time' namespace,
just as the reference for 'pid_for_children' is a 'pid' namespace.
In other words, I think the above time_for_children link should read:

/proc/self/ns/time_for_children -> time:[4026531834]

If you agree with this patch, then it should be marked for
stable@vger.kernel.org.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>

---
 kernel/time/namespace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index e6ba064ce773..3b30288793fe 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -447,6 +447,7 @@ const struct proc_ns_operations timens_operations = {
 
 const struct proc_ns_operations timens_for_children_operations = {
 	.name		= "time_for_children",
+	.real_ns_name	= "time",
 	.type		= CLONE_NEWTIME,
 	.get		= timens_for_children_get,
 	.put		= timens_put,
-- 
2.25.1

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
