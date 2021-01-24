Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD6301BCB
	for <lists+linux-api@lfdr.de>; Sun, 24 Jan 2021 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhAXMUW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Jan 2021 07:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbhAXMUV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Jan 2021 07:20:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED97C061573
        for <linux-api@vger.kernel.org>; Sun, 24 Jan 2021 04:19:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c127so8318104wmf.5
        for <linux-api@vger.kernel.org>; Sun, 24 Jan 2021 04:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxB7sFIhkdFfNASyegI8j5fZfgIskJRC51MEpIRmbBA=;
        b=dacZbrzlGb4FT8BBTvRaDqhJvckM60roK7MwqkJOCW99h2S6ouYuHFiT32/Kue5cyW
         zeT2wuVwW/U25GFILMXUlo7uEDvA04wVIBWfhSws2vfKi1i22tcKWuyE2VQZrmWhzKe5
         KaGXJUlyQ4psiIzODB1Lp/G3PhVl8IUDFzKsmhuLL9s5F/NYoXe9XDusMRzx+pwI5TrW
         oQ3viZZ8/S3oeotjZqiPAFiNCRLcxOIQmZErY9+Gt2tZWDLtYR9l6+BoN0Y1Cm0Xt9qH
         vp6jALRBE6v3oNQHUH88n3nRInfoh0jH2+u6OCiJ+uF3qvSfpQNSQxJcOC4tZOSW8lWL
         AM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxB7sFIhkdFfNASyegI8j5fZfgIskJRC51MEpIRmbBA=;
        b=DmpMu3Oti8CzfzeY8kmr+Bt5ReBuxYiqzGyKAuXsjFTU4Y0hjshbYRntyfySfnyFb+
         p3eCOCBkcVrvc8eCxCzOFqcYq7el3MgwOxsPoeOvbDAwK8rKQToDqLtKwb/pDLtK8ceB
         1zFSnD5E1TswMKCJxS8pg2n+OqCdkRckXpWWLoQUVRmym/odm7f4ZzeXW2k0GxHVD0Y+
         vL3WisGr+Jx03RDUcB8W+PfTkW3dVwiXMv09LrbcSzff1Sx3LUu3IO7d+RfRubbxHfit
         SZE2IqUg9Sm3t/bqsZEZah+Yi5Vty4K883trka2tKTG62e6ECKSUSg/6T3asErAu4QPE
         iPqA==
X-Gm-Message-State: AOAM531HQje6QEXOBiHvQ0H9ra9Vvuw4RRxH0/sXkHJllAet7v87OnO1
        RTUa0SafzjRQkXIZd8lFmcMnSR09ii0=
X-Google-Smtp-Source: ABdhPJz5Z5GPSB9eGxsrOUhA1AgtLGKGLG0h4QMnBuo5WBtxvT4ResoOf2VKlRavQFLJikqXsiz/+Q==
X-Received: by 2002:a05:600c:230e:: with SMTP id 14mr2173459wmo.161.1611490779526;
        Sun, 24 Jan 2021 04:19:39 -0800 (PST)
Received: from debian.vlc ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id n16sm18680871wrj.26.2021.01.24.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 04:19:38 -0800 (PST)
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
Subject: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not write to stdout
Date:   Sun, 24 Jan 2021 13:18:46 +0100
Message-Id: <20210124121845.38293-1-alx.manpages@gmail.com>
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

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---

Resend as v3. I forgot to change the subject line.
Everything else is the same as in
<20210123145356.53962-1-alx.manpages@gmail.com>.

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

