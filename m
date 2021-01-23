Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65BD301618
	for <lists+linux-api@lfdr.de>; Sat, 23 Jan 2021 15:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725274AbhAWOzM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 23 Jan 2021 09:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAWOzM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 23 Jan 2021 09:55:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A12DC06174A
        for <linux-api@vger.kernel.org>; Sat, 23 Jan 2021 06:54:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so7866155wrx.4
        for <linux-api@vger.kernel.org>; Sat, 23 Jan 2021 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNuCFY4s8WBH3encyCheLFmzRuVTMKtmvRgUzDaFPpo=;
        b=a6gZ2wGLMPbIJE0rmpRwrgNfpcXvRjZMghw7CjcrqyWYrQ6C3vG0kYX+18FJ0LLi3+
         toyI17Lz2ODLy1DKZ7hDXAS76Ty/5o1eTd9IYDx36GHGwvLwqvYryEML322+n/7TfgC+
         vjrn2oPAUC2QLKb/eutt298zLpGH9ol93xABchzTpVtdf2Tlplpq0GA/02iNd+RH4PrU
         JyHW4X4J+5MztLSgKXaovsOsqcng4hzs/N8KFtpmu1EQs0JXClZiQaMPEA/IGvyiC9jC
         j8IBLKQcl29Zha9Ja6hoR4Qy/eMCyFzbGHnMy5Ww0D/CIC5X1jFdRWr0zg7WE6mCjYYU
         OUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNuCFY4s8WBH3encyCheLFmzRuVTMKtmvRgUzDaFPpo=;
        b=BFiUbmnxWiXDOnd4CEcrmYM43Qtd27m6JlT0PFUmda8y7BWfHptbaDh+W27yYG0ge4
         EWauwYolk630vB6Qlsb7FhvPpE+97gSsy66+zmjlNCVIdrwfnKEm232CnSDrZ10CFP0i
         naJcBljL8d0KRXE9zHMSHIXV67cDfFY7DmbJIBI1vyx+GsSIZyOwmFAuBh0UKszowYlw
         3gvCSaO5A/2+RIfu7oAdoBrTsbhADnHRoizOTV2T8Y6MiheUNGd05XXQR5kabgflhrsR
         hLZFt1ZohxkwM3j+f+AKjf43BUTrjRVqAPrewmdh7+UsT8CejbEtKNT1xh+mnNuNUl5o
         /X/g==
X-Gm-Message-State: AOAM533wVQgzUe2w4bbjo0OFZmWn+HRfkfM8UHlpp/ZEErv9/OgX1ZO1
        f8QeLsPMkA3AXTNzb38cQ7c=
X-Google-Smtp-Source: ABdhPJw2wxxMuPsRc24xpJeFLqYTfUEF68PmYzA36/s6M0K8DBszwv/JsqohUEMop5Vv6m970riOqQ==
X-Received: by 2002:adf:e384:: with SMTP id e4mr543159wrm.13.1611413670335;
        Sat, 23 Jan 2021 06:54:30 -0800 (PST)
Received: from localhost.localdomain ([170.253.49.0])
        by smtp.googlemail.com with ESMTPSA id w126sm5305792wma.43.2021.01.23.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 06:54:29 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Christian Groessler <chris@groessler.org>,
        =?UTF-8?q?P=C3=A1draig=20Brady?= <P@draigbrady.com>,
        Coreutils <coreutils@gnu.org>,
        William Ahern <william@25thandclement.com>,
        Erik Auerswald <auerswal@unix-ag.uni-kl.de>,
        Eric Pruitt <eric.pruitt@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Fabrice BAUZAC <noon@mykolab.com>, tech@openbsd.org,
        freebsd-hackers@freebsd.org, linux-api@vger.kernel.org,
        juli@clockworksquid.com, ed@nuxi.nl, oshogbo@freebsd.org
Subject: [PATCH] tee: Add -q, --quiet, --silent option to not write to stdout
Date:   Sat, 23 Jan 2021 15:53:57 +0100
Message-Id: <20210123145356.53962-1-alx.manpages@gmail.com>
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
without having to redirect to /dev/null

Example:

echo 'foo' | sudo tee -q /etc/foo;

is equivalent to the old (and ugly)

echo 'foo' | sudo tee /etc/foo >/dev/null;
---

v2: Add --silent synonym to --quiet, per GNU guidelines.
    I tested --silent with success.

v3: Added -q to opstring, which I removed by accident in v2.
    I tested all -q, --quiet and --silent this time.


 src/tee.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/src/tee.c b/src/tee.c
index c81faea91..1dfa92cf2 100644
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
@@ -130,8 +136,9 @@ main (int argc, char **argv)
 
   append = false;
   ignore_interrupts = false;
+  quiet = false;
 
-  while ((optc = getopt_long (argc, argv, "aip", long_options, NULL)) != -1)
+  while ((optc = getopt_long (argc, argv, "aipq", long_options, NULL)) != -1)
     {
       switch (optc)
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

