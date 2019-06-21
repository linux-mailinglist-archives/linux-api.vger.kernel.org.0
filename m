Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5F4DE7F
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfFUBU4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:56 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34868 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfFUBU4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:56 -0400
Received: by mail-qt1-f201.google.com with SMTP id v58so6144422qta.2
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oLNQmjwdlyTKvPjBDmq4/qQl+scekmG8pPkpSVBP2pc=;
        b=PPj8F02Q/dYkdIVv7818Sc92il1uS0VYPm4sWXthtxCkAx9+0zf3l9svFEK/Rd73Bb
         dlP85f8HS0aKqVmiANlJsQ+Pco5gJHleZOmLKZpIFBQYeCNer5LEb8s3B31OyHkjBDsP
         ysf4Em6BGot7MalUqrXsCCES1MBjY0Puxn/ceh8bXMFgDsHRGUYhuHkfO4Kgop5VBH2G
         u2bSHSFpC8HH0U9AaA+FhEG1ewZnSz5d+biNKoE5fRu+5WQpyTBUwW9wTym7HnjODU5s
         4xwIu+uUBF8tmFT1PRVYYo4l732jXA1abWbc7mO6CDc9GFTYsr0uoILvAkJmRxBGSBVs
         lyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oLNQmjwdlyTKvPjBDmq4/qQl+scekmG8pPkpSVBP2pc=;
        b=hFba451pOO/yVhmdExd/9lK5kc7C7jerf8fBIpISceZX+tUy7ft6hEeuravZnSUiG/
         MaCXFZbnkQj/50sVgOa26DfmtQE2ozJicTuYL3R5A18aHDrt4D8tjk7NsWqKqCPTtU/S
         C985t0NnvClwB6zEcSwpGMgUUKSGH87P2Dd4+360FUmDqbQUmLAKAt5IGHFCnjbZ+x5q
         AEhuQO7OZm1YcQSwFm5wkRc+htlP60zVjGLkAe0GFbbtLG7GRt8D2EwzJeK4wsRH1JbE
         V51zDQYkyvvyY3vcN3Tc74O2ukrLFj497yQN/IJhH77zUZzWLggN2InF9kEJbgCMTw33
         L9Lg==
X-Gm-Message-State: APjAAAXMNZEaCnJSiLwC/YlLb7XSGtOo+S4G2oBOwjhZkT4oS1hCQmT5
        CegHl1smMIARRVjjJfHu45WS24m5YJ2KDDdBVLvF7A==
X-Google-Smtp-Source: APXvYqzVfKAHLyvmgbEKs2IA4V8STQmr8uSJX9H4d973pIOIUIcJOsyPjG8NVzLRpqoatRWkJ8KtW4Mr/cQnGJCcLgof9A==
X-Received: by 2002:a37:dc45:: with SMTP id v66mr50354812qki.24.1561080055557;
 Thu, 20 Jun 2019 18:20:55 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:38 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-28-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 27/30] lockdown: Print current->comm in restriction messages
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Print the content of current->comm in messages generated by lockdown to
indicate a restriction that was hit.  This makes it a bit easier to find
out what caused the message.

The message now patterned something like:

        Lockdown: <comm>: <what> is restricted; see man kernel_lockdown.7

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 security/lockdown/lockdown.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 14edc475d75c..408f0048f8a2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -80,8 +80,8 @@ early_param("lockdown", lockdown_param);
 static int lockdown_is_locked_down(enum lockdown_reason what)
 {	
 	if ((kernel_locked_down >= what) && lockdown_reasons[what])
-		pr_notice("Lockdown: %s is restricted; see man kernel_lockdown.7\n",
-			  lockdown_reasons[what]);
+		pr_notice("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
+			  current->comm, lockdown_reasons[what]);
 	return (kernel_locked_down >= what);
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

