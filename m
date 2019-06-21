Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C84DE6A
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfFUBUL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:11 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52445 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfFUBUL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:11 -0400
Received: by mail-pf1-f201.google.com with SMTP id a20so3234801pfn.19
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t/mH/2CAOnOWxHMVmIaOFtnDHIg0vKk910CbpA/m5hE=;
        b=ZrJDgzp2uG5EFeE4+0LjPFkV0TGUObRy4jaKbEQsMbGFlQmn6fopYXvd1LW8FCJjlf
         xqMgiWJHsarOqLc2NOHcvP5PUfYuofixZBCz9FuBma8aOFOF4vuTt5CRSL4fLm8BVxyR
         rAxZYQJ3kH92QKEWj+SInFl8VP1HMViB/TXI+hKbeI+s34xQyFt73DCMooaFgNRJb+Lg
         NWivhN7v4xaXLLeTEDkh1u5hYzRNZ3BTfnX1d1KRKBiqnCtA4L7i1elgetxINyuQwZNQ
         b8WeC3kT/TTr+6Tac8XSU9ovBR5flmyV+hwqTZ70a5EHt5+aTJNkpBM/Kf4eEWFGAw6t
         3B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t/mH/2CAOnOWxHMVmIaOFtnDHIg0vKk910CbpA/m5hE=;
        b=c7WJ88cZtjohEy9YwrzXAeE84KMcojHQ7auSrb6d0o7c3skApr6B1OFfmloJ8wpFcG
         vM3428l1N7fEvrS+fo5V91RgVUlbfhg3y9NGZDOXAzF6YJPBBYmv1kSpKeVEvSGnUldU
         diIKs6LQ5DrueLpPWRmUaBMny7D/xKPsdlb8Voy0gnQjFGqhxXHiXyVuI1InViz0dsVx
         ouuf+Wnb1kXBZ9DqZdTCapgWOYN5FeOhzJhpYHoDKHMA6Q07fpoyd6P/Mig1Hi7TdmBb
         PwSoudQn3IYOBRPOo+encHgAUpkZmSTppZZmrdDw5M0o+aabu3HBjwfdebYB+7SKAWFS
         Dtdg==
X-Gm-Message-State: APjAAAU4gjmg8kVJcCpuZ8Phds5raXA8GPljeHMiEcKn+wZUxYP9Xtof
        Ook7gIBfhi6qtpFnwerrb5cb+zX+zjS9Xq133wu92g==
X-Google-Smtp-Source: APXvYqzxVqdSAIqmyaFpVNbAosUNxFCJA3loM78boAjh/0nuxooUctORb4Dj+NHACmdIFlF6J9m5m/dkrFISvkP8/LXfHg==
X-Received: by 2002:a63:f4e:: with SMTP id 14mr15526503pgp.58.1561080010211;
 Thu, 20 Jun 2019 18:20:10 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:20 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 09/30] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 67f3a866eabe..455f4fc794f3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+
+		if (security_is_locked_down(LOCKDOWN_KEXEC)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.22.0.410.gd8fdbe21b5-goog

