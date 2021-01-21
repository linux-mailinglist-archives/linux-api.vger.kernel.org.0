Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E16F2FF8B0
	for <lists+linux-api@lfdr.de>; Fri, 22 Jan 2021 00:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhAUXXe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Jan 2021 18:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhAUXXN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Jan 2021 18:23:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F3AC061788
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 15:22:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a1so3368506wrq.6
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 15:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9FDY2AsftqpnWiw70OlOmAdNNuO2TtWc7rPYaOD/c8=;
        b=mSiM13M6wR18Hv+ZD8azvoVTQlTt3ftyjoBf9IyCywWv6DDhFLWZR4UMXFclwaZFs7
         wRTRjipAq9Z4QVVtHpxnUr3pgZH3jIvAD6MbptqKh8+G/ElXYiT2SjgkE3RSfSnXO1KE
         qgTUP8f19DRS4KA2BTOoyJKYWFdS276qBUw1xbVkbslma2YykAOeaocHmOvAh383b/p6
         q9cbga1j9whjrT5mTiToiCvsSYkVYRxqCk1OK1iSGKp5IBxuxqgyPKMa7ntI20vPBmaU
         Q+6mwJ2DjXgpzLCK+wae2vUTWY/7Cma1YtZn/G4ZD9FPzCOAsVoKZ3MXTK/96o3vj3Q6
         6xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9FDY2AsftqpnWiw70OlOmAdNNuO2TtWc7rPYaOD/c8=;
        b=s0HiFGrr5FUs4qzYgvq1/x09Up7FT0Fxizf7VKWW3QfXGEpb+XklcYZ1Lo5x50mp1I
         /ozatDZKgT/11sYO9y961vjWirHbgfu5vHhyLIhYElRZXi7VJdj6nDAg38a9+y1+UbOo
         EiqH5YenYbDRaFH2DQnybFPuJR9HCU1DnWALWYxGtFwkLd1Wns4vDE1xwO0gEHCBavYY
         gbTCfsjgMpZ+sHc6e9Er5AX/rsvAJIn2bb03sG+OKnKMsJ69rB9+p+POz+xKbePLSoDi
         ttge0J5QiDkHXoGq4yAcQcZtJtD2ONYibEZoLsbg0j3xcXaF8ncjjk0QcfEih4FrPgvT
         27kg==
X-Gm-Message-State: AOAM5313DDYPRdpeR9wCXy2akSkzsDVjhjeOBjWiNROnbyQUuZPJbRlU
        /RWwHl7O0yD5Yrwa+oaRNw4=
X-Google-Smtp-Source: ABdhPJyh6DbEyMPC9TmLy6HnUsCOg+0Shqryp4BlWjtTdUhuaMkb7gMQRSHRzGJRm7Ng9rSBvNHT1w==
X-Received: by 2002:adf:ee90:: with SMTP id b16mr1613910wro.221.1611271351875;
        Thu, 21 Jan 2021 15:22:31 -0800 (PST)
Received: from localhost.localdomain ([170.253.49.0])
        by smtp.googlemail.com with ESMTPSA id o17sm3799418wrp.34.2021.01.21.15.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:22:31 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Christian Groessler <chris@groessler.org>,
        =?UTF-8?q?P=C3=A1draig=20Brady?= <P@draigbrady.com>,
        Coreutils <coreutils@gnu.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, noloader@gmail.com,
        Fabrice BAUZAC <noon@mykolab.com>, tech@openbsd.org,
        freebsd-hackers@freebsd.org, linux-api@vger.kernel.org
Subject: [PATCH v2] tee: Add -q, --quiet, --silent option to not write to stdout
Date:   Fri, 22 Jan 2021 00:12:58 +0100
Message-Id: <20210121231255.2673075-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is useful for using tee to just write to a file,
at the end of a pipeline,
without having to redirect to /dev/null.

Example:
	echo 'foo' | sudo tee -q /etc/foo;
is equivalent to the old (and ugly)
	echo 'foo' | sudo tee /etc/foo >/dev/null;

Tools with a similar interface: grep

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---

v2: Add --silent synonym to --quiet, per GNU guidelines.
    I tested tee --silent with success.

 src/tee.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/tee.c b/src/tee.c
index c81faea91..68ace983a 100644
--- a/src/tee.c
+++ b/src/tee.c
@@ -45,6 +45,9 @@ static bool append;
 /* If true, ignore interrupts. */
 static bool ignore_interrupts;
 
+/* Don't write to stdout */
+static bool quiet;
+
 enum output_error
   {
     output_error_sigpipe,      /* traditional behavior, sigpipe enabled.  */
@@ -61,6 +64,8 @@ static struct option const long_options[] =
   {"append", no_argument, NULL, 'a'},
   {"ignore-interrupts", no_argument, NULL, 'i'},
   {"output-error", optional_argument, NULL, 'p'},
+  {"quiet", no_argument, NULL, 'q'},
+  {"silent", no_argument, NULL, 'q'},
   {GETOPT_HELP_OPTION_DECL},
   {GETOPT_VERSION_OPTION_DECL},
   {NULL, 0, NULL, 0}
@@ -93,6 +98,7 @@ Copy standard input to each FILE, and also to standard output.\n\
 "), stdout);
       fputs (_("\
   -p                        diagnose errors writing to non pipes\n\
+  -q, --quiet, --silent     don't write to standard output\n\
       --output-error[=MODE]   set behavior on write error.  See MODE below\n\
 "), stdout);
       fputs (HELP_OPTION_DESCRIPTION, stdout);
@@ -130,6 +136,7 @@ main (int argc, char **argv)
 
   append = false;
   ignore_interrupts = false;
+  quiet = false;
 
   while ((optc = getopt_long (argc, argv, "aip", long_options, NULL)) != -1)
     {
@@ -151,6 +158,10 @@ main (int argc, char **argv)
             output_error = output_error_warn_nopipe;
           break;
 
+        case 'q':
+          quiet = true;
+          break;
+
         case_GETOPT_HELP_CHAR;
 
         case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
@@ -235,8 +246,9 @@ tee_files (int nfiles, char **files)
         break;
 
       /* Write to all NFILES + 1 descriptors.
-         Standard output is the first one.  */
-      for (i = 0; i <= nfiles; i++)
+         Standard output is the first one.
+         If 'quiet' is true, write to descriptors 1 and above (omit stdout)  */
+      for (i = quiet; i <= nfiles; i++)
         if (descriptors[i]
             && fwrite (buffer, bytes_read, 1, descriptors[i]) != 1)
           {
-- 
2.30.0

