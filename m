Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8557AEE21
	for <lists+linux-api@lfdr.de>; Tue, 26 Sep 2023 15:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjIZNnv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Sep 2023 09:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZNnu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Sep 2023 09:43:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC13A95
        for <linux-api@vger.kernel.org>; Tue, 26 Sep 2023 06:43:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so8436636f8f.2
        for <linux-api@vger.kernel.org>; Tue, 26 Sep 2023 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695735822; x=1696340622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptamfMpXoJ3CODle1KvFafVhoHAycVMWOruc5QELg+E=;
        b=gFiLzWvgNJVmF699Cqrqu4+R2LyjPqbMaVQK71IZzRhA9854OzKw8FWriPbCA9+3vO
         TarL1CLrD40m57jQTX6e/RfvM6lz9fmFOdcAF17Eny5ebKgRpXXkc70dBGroWQZLvFMI
         cl1mZrrM6pQ28VKoy6qf92BAmSUhUeBM5inzsfXi0NgqhNGutAqkC3qhTwy+yKp49Ows
         tPaIFQPEbBcpMRN7unIsY8pb4bjZwAwhM7IAQyaAbA65mBPf2C0hq7ij3nMpKlIP77fg
         a2LJTbE9DD0HgA7tcrb+6R2vnfzvjl+SQZLopnrItRI5hUvPRxFmVasvuoIKqqrloi37
         eDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695735822; x=1696340622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptamfMpXoJ3CODle1KvFafVhoHAycVMWOruc5QELg+E=;
        b=OG5cp3PFCzTcg7pbxaGQDeb4X0TsNO5XMKAiUnonAoIx4aqs8U7rAFgQfzcS//p1w7
         QzcC7bTP2S5C1cUROH3Qy+u/f9ABN18cR76fb4J0P87bmd+KFZmZs06dMjpElX0Kr4Jq
         S+MTRouSDcN9nvVxUg8IV1r6zQJNIm+phDmbSMrxAJ8nX/Ry3ve+O4eNc9oZLFk4JwFO
         qCLElnDkCZiyP/MTvd3Nxmw5RciELY40V3nNclSRBCe5lQZjTFR7Q0jrCXBPkNkDPNnL
         3c6Z3y+5hMBSAkJglrkiosUJUtZiUD/M3b93kIMgspQTdydBkxzaaH7VgdvPiXOv+t+0
         xNHQ==
X-Gm-Message-State: AOJu0YyIFSBjcdNgCDeiJ1qjlABve5M3GhatbMcNGUMkdfa0YtwroX+T
        Wgkq5j9hqPBW0UjJWXV0weSISA==
X-Google-Smtp-Source: AGHT+IGQUe3IdNmMk57bmfL8PJu8M+EYO3SZyr5D1RurisMB/DzXyNogPvyzvVGvHPFXaPY+8ZIKlA==
X-Received: by 2002:adf:ed0d:0:b0:315:9676:c360 with SMTP id a13-20020adfed0d000000b003159676c360mr8793528wro.25.1695735822316;
        Tue, 26 Sep 2023 06:43:42 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d474d000000b003217cbab88bsm14644490wrs.16.2023.09.26.06.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 06:43:41 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     alx@kernel.org, linux-man@vger.kernel.org, brauner@kernel.org,
        axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] man2/splice.2: document SPLICE_F_NOWAIT
Date:   Tue, 26 Sep 2023 15:43:39 +0200
Message-Id: <20230926134339.2919289-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <hq2223k3kdclg2i2ozwtw37yvtwnxwrw3ns4op4fkh76x3fz47@2frhfofkwzay>
References: <hq2223k3kdclg2i2ozwtw37yvtwnxwrw3ns4op4fkh76x3fz47@2frhfofkwzay>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Patch for SPLICE_F_NOWAIT submitted to LKML:
 https://lore.kernel.org/lkml/20230926063609.2451260-1-max.kellermann@ionos.com/

In the HISTORY section, I declared Linux 6.7 as the first version to
have this feature, but this is only speculation, because
SPLICE_F_NOWAIT is still under discussion and has not yet been merged.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 man2/splice.2 | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/man2/splice.2 b/man2/splice.2
index e9a18e668..a07c001ac 100644
--- a/man2/splice.2
+++ b/man2/splice.2
@@ -89,13 +89,26 @@ call);
 in the future, a correct implementation may be restored.
 .TP
 .B SPLICE_F_NONBLOCK
-Do not block on I/O.
+Do not block on I/O on pipes.
 This makes the splice pipe operations nonblocking, but
 .BR splice ()
 may nevertheless block because the file descriptors that
 are spliced to/from may block (unless they have the
 .B O_NONBLOCK
-flag set).
+flag set or
+.B SPLICE_F_NOWAIT
+is specified).
+.TP
+.B SPLICE_F_NOWAIT
+If no data is immediately available on
+.I fd_in
+and it is not a pipe, do not wait (e.g. for backing storage or locks),
+but return immediately with
+.B EAGAIN.
+This is analogous to the
+.B RWF_NOWAIT
+flag of
+.BR preadv2 ().
 .TP
 .B SPLICE_F_MORE
 More data will be coming in a subsequent splice.
@@ -138,6 +151,8 @@ is set to indicate the error.
 .TP
 .B EAGAIN
 .B SPLICE_F_NONBLOCK
+or
+.B SPLICE_F_NOWAIT
 was specified in
 .I flags
 or one of the file descriptors had been marked as nonblocking
@@ -192,6 +207,9 @@ was required to be a pipe.
 Since Linux 2.6.31,
 .\" commit 7c77f0b3f9208c339a4b40737bb2cb0f0319bb8d
 both arguments may refer to pipes.
+.PP
+.B SPLICE_F_NOWAIT
+was added in Linux 6.7.
 .SH NOTES
 The three system calls
 .BR splice (),
-- 
2.39.2

