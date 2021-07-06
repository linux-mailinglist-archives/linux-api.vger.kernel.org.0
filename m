Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721D73BD6F5
	for <lists+linux-api@lfdr.de>; Tue,  6 Jul 2021 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhGFMsy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Jul 2021 08:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbhGFMsl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Jul 2021 08:48:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB8C08E886
        for <linux-api@vger.kernel.org>; Tue,  6 Jul 2021 05:41:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i8so13027084wrp.12
        for <linux-api@vger.kernel.org>; Tue, 06 Jul 2021 05:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=co2CdYXFE7Ol3YA8dMqb29CNEHa7yCiGPitI5faXCjs=;
        b=VSX7etRg+C/iteL/+Pb2AdgcflfCAwFn3ui7ugZTOUwrS12OZTDV9tPDDN2wwwCh6w
         bgyrJ6QxxX4XD2miuFTTcHYoqtHcqhQNqN2PUWR+ztdNuTjSBc/I0W/Ftbi03lSNGG5s
         hD9/kqv5ph+ayeA83Je8wsNvLkFRLOpF57+yE82a6/2XRW6TVghkWgyj25p07Rc6ZuVO
         0yK6WbZclRm0qm/xszR+c8Nrk6EAi1J7itus+tEqU5vVBUj7yYft3VlFzPtFJkm5VVxc
         GQFFyA0DLA7It2XZU/oaPq+2A4Gp86jQFWZeYfepa9sY0TSbwEvSqrZSSJqQ9t5wI+41
         JDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=co2CdYXFE7Ol3YA8dMqb29CNEHa7yCiGPitI5faXCjs=;
        b=hIYC4NcqZUDDISQ+6UBWIP4OQTrH5gPk0L2+B51fk7xKj6kRnMWkhEM+eY3uK+bHzH
         hXquFsGFLTDsezBwfk4s9YRtDV0AOZWwSoobrv4PD12+5G4rMz1uR4QeYEAMui9Kp9HV
         l1p5G1YWAqiuvZ2TBdLxuoIR9yNs2aoexnHECPCX6WLCF4I035oFQDX0FPD14mD5NNqi
         BrNbYbexnVoLvRdSKumaKepgnK5eaI5JFXTf4gf6Fp6fPqHFC/yCff1MpJRwyTBPNsfR
         mq9cP0Swsu4NCUEwbPvI0zYDv3+eB/3fnjQkeEAoT3ioZ25ni6ZBvASgG+3exulC9D8c
         IK6Q==
X-Gm-Message-State: AOAM533V+suDqqTZq3BPivRrdKvHwkmUkI//D/6SxwP+VIChBqllsRGW
        qLmuMHDS2Jh7whPbteJ2B8GdrrRhVzMKZQ==
X-Google-Smtp-Source: ABdhPJxS4TH7SeppkR7aTUrIgzMdkRTUiLyRaR7vSDAXwseluDbqNAVMEsaLquWusMulqVeQ7udjYA==
X-Received: by 2002:adf:f642:: with SMTP id x2mr17929574wrp.37.1625575268165;
        Tue, 06 Jul 2021 05:41:08 -0700 (PDT)
Received: from localhost.localdomain (hst-221-27.medicom.bg. [84.238.221.27])
        by smtp.gmail.com with ESMTPSA id n18sm2585979wms.3.2021.07.06.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 05:41:07 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 2/5] venus: helpers: Add helper to check supported pixel formats
Date:   Tue,  6 Jul 2021 15:40:31 +0300
Message-Id: <20210706124034.773503-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
References: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a helper to check supported pixel format per codec and session
type.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 23 +++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 1fe6d463dc99..48da88d21ccd 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1725,6 +1725,29 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
 }
 EXPORT_SYMBOL_GPL(venus_helper_get_out_fmts);
 
+bool venus_helper_check_format(struct venus_inst *inst, u32 v4l2_pixfmt)
+{
+	struct venus_core *core = inst->core;
+	u32 fmt = to_hfi_raw_fmt(v4l2_pixfmt);
+	struct hfi_plat_caps *caps;
+	u32 buftype;
+
+	if (!fmt)
+		return false;
+
+	caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
+	if (!caps)
+		return false;
+
+	if (inst->session_type == VIDC_SESSION_TYPE_DEC)
+		buftype = HFI_BUFFER_OUTPUT2;
+	else
+		buftype = HFI_BUFFER_OUTPUT;
+
+	return find_fmt_from_caps(caps, buftype, fmt);
+}
+EXPORT_SYMBOL_GPL(venus_helper_check_format);
+
 int venus_helper_set_stride(struct venus_inst *inst,
 			    unsigned int width, unsigned int height)
 {
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index e6269b4be3af..00ecb39d7f6b 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -51,6 +51,7 @@ void venus_helper_init_instance(struct venus_inst *inst);
 int venus_helper_session_init(struct venus_inst *inst);
 int venus_helper_get_out_fmts(struct venus_inst *inst, u32 fmt, u32 *out_fmt,
 			      u32 *out2_fmt, bool ubwc);
+bool venus_helper_check_format(struct venus_inst *inst, u32 v4l2_pixfmt);
 int venus_helper_alloc_dpb_bufs(struct venus_inst *inst);
 int venus_helper_free_dpb_bufs(struct venus_inst *inst);
 int venus_helper_intbufs_alloc(struct venus_inst *inst);
-- 
2.25.1

