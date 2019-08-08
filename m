Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDCC6856E4
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389743AbfHHAI2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:08:28 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39679 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389731AbfHHAIY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:08:24 -0400
Received: by mail-qk1-f201.google.com with SMTP id x1so80729656qkn.6
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8yt0J0pt8aHuQPT7nXOB+XR/9vHKjGA14LTvJs583ko=;
        b=R/kcNwmgbX+sKxSEQsYUzy5uU1k4FuUGmKARS2fBkMDe+ZiZsiyQt4yd4lR2R6nsjb
         wpjUNdDlXARvS5FUlu+PthqfTsorWtf88u58FgL5DuOglBXkEUFf7g8Wu357CPD1PEj5
         58PkL4hmWYOY6O8/DHp19TdCXlQTC0/7jAjVyZ3EbA8nlErkBnnDpNrUXmd6bZLaLCSp
         7+JRhvoUP7mO5NTA3UhzFDk0WXgQYiBqgdLwiUahFgrbJ15hUKqPL5FbLDdHBnCsuzTv
         1cFf2P13Z4ho/mB37/OdEUSP3mKSUvgH6BHIR9A0yKppvEfzMfT+TzvFoDGYMESasC8r
         2Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8yt0J0pt8aHuQPT7nXOB+XR/9vHKjGA14LTvJs583ko=;
        b=WvYZurvMWoYjockPFCyJLBNQXF5H2PXZiXlXMAqTMsA/EqnSevvHtypRzrWme6Vvya
         /1ZWFsaYZuXiI1LJbYGdorhbvJB8j56+phj7A88A3YH7Mqiqw9afdLqxym4cQs5bkudb
         K51L4m3VV2OLuDJQqTqmZiKY5mMA+CTdGv6JkSw8pQ9vmalyyQC+DMZE5vewuUrAkqwN
         QEHn7U0qqPgD8qVoHV0Ujg9bY1ItJ/9WySYT0p1QgWikZCZC50zdFcAEfih7R1vrZDNo
         9mxflcT5rZn0+0vdyxxnLNuqaqea9HqtGhBBbVw/tSrjERMn/3x176YzejwY+spkpxGw
         +LHQ==
X-Gm-Message-State: APjAAAUcqIczVvgiAAPZ/BfjfuI8f68OPS20ybOzIGlmejRmgwKg7Cbd
        shXHyVJv+TQ2wJ9KKY2+7cEGlxixuWkK3YN0UDQQhg==
X-Google-Smtp-Source: APXvYqyjnlsGnir4nPy3hMLpW07ohKztD3RxPsYLY3A/Sa4cuV8dEjDRbdbOmPFer08xkz1jJqjDaeOS+XOGyZFIuh1wyA==
X-Received: by 2002:a37:90c2:: with SMTP id s185mr11369315qkd.161.1565222903745;
 Wed, 07 Aug 2019 17:08:23 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:15 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-24-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

bpf_read() and bpf_read_str() could potentially be abused to (eg) allow
private keys in kernel memory to be leaked. Disable them if the kernel
has been locked down in confidentiality mode.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: netdev@vger.kernel.org
cc: Chun-Yi Lee <jlee@suse.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/security.h     |  1 +
 kernel/trace/bpf_trace.c     | 10 ++++++++++
 security/lockdown/lockdown.c |  1 +
 3 files changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 987d8427f091..8dd1741a52cd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -118,6 +118,7 @@ enum lockdown_reason {
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
+	LOCKDOWN_BPF_READ,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ca1255d14576..492a8bfaae98 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -142,8 +142,13 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret < 0)
+		goto out;
+
 	ret = probe_kernel_read(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
+out:
 		memset(dst, 0, size);
 
 	return ret;
@@ -569,6 +574,10 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_BPF_READ);
+	if (ret < 0)
+		goto out;
+
 	/*
 	 * The strncpy_from_unsafe() call will likely not fill the entire
 	 * buffer, but that's okay in this circumstance as we're probing
@@ -580,6 +589,7 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
 	 */
 	ret = strncpy_from_unsafe(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
+out:
 		memset(dst, 0, size);
 
 	return ret;
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 6b123cbf3748..1b89d3e8e54d 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -33,6 +33,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
+	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.770.g0f2c4a37fd-goog

